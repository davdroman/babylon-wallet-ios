import Common
import ComposableArchitecture
import CryptoKit
import EngineToolkit
import EngineToolkitClient
import Foundation
import SLIP10

// MARK: - Date + Sendable
extension Date: @unchecked Sendable {}

// MARK: - ExpectedHTTPURLResponse
struct ExpectedHTTPURLResponse: Swift.Error {}

// MARK: - BadHTTPResponseCode
struct BadHTTPResponseCode: Swift.Error {
	let got: Int
	let butExpected = Self.expected
	static let expected = 200
}

public extension GatewayAPIClient {
	static func live(
		baseURL: URL = .init(string: "https://alphanet.radixdlt.com/v0")!,
		urlSession: URLSession = .shared,
		jsonEncoder: JSONEncoder = .init(),
		jsonDecoder: JSONDecoder = .init()
	) -> Self {
		@Sendable
		func makeRequest<Response>(
			httpBodyData httpBody: Data?,
			method: String = "POST",
			responseType _: Response.Type,
			urlFromBase: (URL) -> URL
		) async throws -> Response where Response: Decodable {
			let url = urlFromBase(baseURL)
			var urlRequest = URLRequest(url: url)
			urlRequest.httpMethod = method
			if let httpBody {
				urlRequest.httpBody = httpBody
			}

			urlRequest.allHTTPHeaderFields = [
				"accept": "application/json",
				"Content-Type": "application/json",
			]

			let (data, urlResponse) = try await urlSession.data(for: urlRequest)

			guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
				throw ExpectedHTTPURLResponse()
			}

			guard httpURLResponse.statusCode == BadHTTPResponseCode.expected else {
				throw BadHTTPResponseCode(got: httpURLResponse.statusCode)
			}

			let response = try jsonDecoder.decode(Response.self, from: data)

			return response
		}

		@Sendable
		func makeRequest<Response>(
			httpBodyData httpBody: Data?,
			method: String = "POST",
			urlFromBase: @escaping (URL) -> URL
		) async throws -> Response where Response: Decodable {
			try await makeRequest(
				httpBodyData: httpBody,
				method: method,
				responseType: Response.self,
				urlFromBase: urlFromBase
			)
		}

		@Sendable
		func post<Response>(
			urlFromBase: @escaping (URL) -> URL
		) async throws -> Response where Response: Decodable {
			try await makeRequest(httpBodyData: nil, responseType: Response.self, urlFromBase: urlFromBase)
		}

		@Sendable
		func post<Request, Response>(
			request: Request,
			urlFromBase: @escaping (URL) -> URL
		) async throws -> Response
			where
			Request: Encodable, Response: Decodable
		{
			jsonEncoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
			let httpBody = try jsonEncoder.encode(request)

			return try await makeRequest(httpBodyData: httpBody, urlFromBase: urlFromBase)
		}

		let getEpoch: GetEpoch = {
			try await post { $0.appendingPathComponent("state/epoch") }
		}

		return Self(
			getEpoch: getEpoch,
			accountResourcesByAddress: { accountAddress in
				try await post(
					request: V0StateComponentRequest(componentAddress: accountAddress.address)
				) { $0.appendingPathComponent("state/component") }
			},
			resourceDetailsByResourceIdentifier: { resourceAddress in
				try await post(
					request: V0StateResourceRequest(resourceAddress: resourceAddress)
				) { $0.appendingPathComponent("state/resource") }
			},
			submitTransaction: { transactionSubmitRequest in
				try await post(
					request: transactionSubmitRequest
				) { $0.appendingPathComponent("transaction/submit") }
			},
			transactionStatus: { transactionStatusRequest in
				try await post(
					request: transactionStatusRequest
				) { $0.appendingPathComponent("transaction/status") }
			},
			getCommittedTransaction: { request in
				try await post(
					request: request
				) { $0.appendingPathComponent("transaction/receipt") }
			}
		)
	}
}

// MARK: - FailedToSubmitTransactionWasDuplicate
struct FailedToSubmitTransactionWasDuplicate: Swift.Error {}

// MARK: - FailedToSubmitTransactionWasRejected
struct FailedToSubmitTransactionWasRejected: Swift.Error {}

// MARK: - FailedToGetTransactionStatus
struct FailedToGetTransactionStatus: Swift.Error {}

// MARK: - TXWasSubmittedButNotSuccessfully
struct TXWasSubmittedButNotSuccessfully: Swift.Error {}

// MARK: - PollStrategy
public struct PollStrategy {
	public let maxPollTries: Int
	public let sleepDuration: TimeInterval
	public init(maxPollTries: Int, sleepDuration: TimeInterval) {
		self.maxPollTries = maxPollTries
		self.sleepDuration = sleepDuration
	}

	public static let `default` = Self(maxPollTries: 20, sleepDuration: 2)
}

public extension GatewayAPIClient {
	// MARK: -

	// MARK: Submit TX Flow
	func submit(
		pollStrategy: PollStrategy = .default,
		signedCompiledNotarizedTXGivenEpoch: (Epoch) async throws -> SignedCompiledNotarizedTX
	) async throws -> (committedTransaction: CommittedTransaction, txID: TXID) {
		@Dependency(\.mainQueue) var mainQueue

		// MARK: Get Epoch
		let epochResponse = try await getEpoch()
		let epoch = Epoch(rawValue: .init(epochResponse.epoch))

		// MARK: Build & Sign TX
		let signedCompiledNotarizedTX = try await signedCompiledNotarizedTXGivenEpoch(epoch)

		// MARK: Submit TX
		let submitTransactionRequest = V0TransactionSubmitRequest(
			notarizedTransactionHex: signedCompiledNotarizedTX.compileNotarizedTransactionIntentResponse.compiledNotarizedIntent.hex
		)

		let response = try await submitTransaction(submitTransactionRequest)
		guard !response.duplicate else {
			throw FailedToSubmitTransactionWasDuplicate()
		}

		// MARK: Poll Status
		var txStatus: V0TransactionStatusResponse.IntentStatus = .unknown
		let intentHash = signedCompiledNotarizedTX.intentHash.hex
		@Sendable func pollTransactionStatus() async throws -> V0TransactionStatusResponse.IntentStatus {
			let txStatusRequest = V0TransactionStatusRequest(
				intentHash: intentHash
			)
			let txStatusResponse = try await transactionStatus(txStatusRequest)
			return txStatusResponse.intentStatus
		}

		var pollCount = 0
		while !txStatus.isComplete {
			defer { pollCount += 1 }
			try await mainQueue.sleep(for: .seconds(pollStrategy.sleepDuration))
			txStatus = try await pollTransactionStatus()
			if pollCount >= pollStrategy.maxPollTries {
				throw FailedToGetTransactionStatus()
			}
		}
		guard txStatus == .committedSuccess else {
			throw TXWasSubmittedButNotSuccessfully()
		}

		// MARK: Get Commited TX

		let getCommittedTXRequest = V0CommittedTransactionRequest(
			intentHash: intentHash
		)
		let committedResponse = try await getCommittedTransaction(getCommittedTXRequest)
		let committed = committedResponse.committed

		guard committed.receipt.status == .succeeded else {
			throw FailedToSubmitTransactionWasRejected()
		}
		let txID = TXID(rawValue: intentHash)
		return (committed, txID)
	}
}

public extension V0TransactionStatusResponse.IntentStatus {
	var isComplete: Bool {
		switch self {
		case .committedSuccess, .committedFailure, .rejected: return true
		case .unknown, .inMempool: return false
		}
	}
}

#if DEBUG
// https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe
extension Data {
	/// NSString gives us a nice sanitized debugDescription
	var prettyPrintedJSONString: NSString? {
		guard
			let object = try? JSONSerialization.jsonObject(with: self, options: []),
			let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
			let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
		else { return nil }

		return prettyPrintedString
	}
}
#endif
