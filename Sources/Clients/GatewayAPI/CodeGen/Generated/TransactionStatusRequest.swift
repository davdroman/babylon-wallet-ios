//
// TransactionStatusRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import ClientPrelude
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionStatusRequest")
public typealias TransactionStatusRequest = GatewayAPI.TransactionStatusRequest

// MARK: - GatewayAPI.TransactionStatusRequest
public extension GatewayAPI {
	struct TransactionStatusRequest: Codable, Hashable {
		public private(set) var atLedgerState: LedgerStateSelector?
		public private(set) var intentHashHex: String?

		public init(atLedgerState: LedgerStateSelector? = nil, intentHashHex: String? = nil) {
			self.atLedgerState = atLedgerState
			self.intentHashHex = intentHashHex
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case atLedgerState = "at_ledger_state"
			case intentHashHex = "intent_hash_hex"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encodeIfPresent(atLedgerState, forKey: .atLedgerState)
			try container.encodeIfPresent(intentHashHex, forKey: .intentHashHex)
		}
	}
}
