@testable import EngineToolkit
import Prelude

// MARK: - SborEncodeDecodeRequestTests
final class SborEncodeDecodeRequestTests: TestCase {
	override func setUp() {
		debugPrint = false
		super.setUp()
	}

	func test__encodeDecodeAddressRequest() throws {
		try TestSuite.vectors.enumerated().forEach { try doTest(vector: $1, index: $0) }
	}
}

extension SborEncodeDecodeRequestTests {
	private func doTest(
		vector: SborDecodeEncodeTestVectors.Vector,
		index: Int,
		networkID: NetworkID = .simulator,
		line: UInt = #line
	) throws {
		let decodeRequest = try SborDecodeRequest(
			encodedHex: vector.encoded,
			networkId: .mainnet
		)
		let decoded = try sut.sborDecodeRequest(request: decodeRequest).get()
		XCTAssertNoDifference(decoded.value, vector.decoded, line: line)

		let encodeRequest = vector.decoded
		let encoded = try sut.sborEncodeRequest(request: encodeRequest).get()
		XCTAssertNoDifference(encoded.encodedValue, try [UInt8](hex: vector.encoded), line: line)
	}

	fileprivate typealias TestSuite = SborDecodeEncodeTestVectors
}

// MARK: - SborDecodeEncodeTestVectors
// NOTE: We will need to update these test vectors if SBOR gets updated.
enum SborDecodeEncodeTestVectors {
	typealias Vector = (encoded: String, decoded: Value_)
	static let vectors: [Vector] = [
		// SBOR Primitive Types
		(
			encoded: "5c0100",
			decoded: .boolean(false)
		),
	]
}