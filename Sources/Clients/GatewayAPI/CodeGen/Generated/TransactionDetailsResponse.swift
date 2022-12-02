//
// TransactionDetailsResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionDetailsResponse")
public typealias TransactionDetailsResponse = GatewayAPI.TransactionDetailsResponse

// MARK: - GatewayAPI.TransactionDetailsResponse
public extension GatewayAPI {
	struct TransactionDetailsResponse: Codable, Hashable {
		public private(set) var ledgerState: LedgerState
		public private(set) var transaction: TransactionInfo
		public private(set) var details: TransactionDetails

		public init(ledgerState: LedgerState, transaction: TransactionInfo, details: TransactionDetails) {
			self.ledgerState = ledgerState
			self.transaction = transaction
			self.details = details
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case ledgerState = "ledger_state"
			case transaction
			case details
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(ledgerState, forKey: .ledgerState)
			try container.encode(transaction, forKey: .transaction)
			try container.encode(details, forKey: .details)
		}
	}
}