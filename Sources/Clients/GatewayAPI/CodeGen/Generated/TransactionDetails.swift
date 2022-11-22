//
// TransactionDetails.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionDetails")
public typealias TransactionDetails = GatewayAPI.TransactionDetails

// MARK: - GatewayAPI.TransactionDetails
public extension GatewayAPI {
	struct TransactionDetails: Codable, Hashable {
		/** The raw transaction payload, hex encoded. */
		public private(set) var rawHex: String
		public private(set) var referencedGlobalEntities: [String]
		/** The message bytes, hex encoded. */
		public private(set) var messageHex: String?

		public init(rawHex: String, referencedGlobalEntities: [String], messageHex: String? = nil) {
			self.rawHex = rawHex
			self.referencedGlobalEntities = referencedGlobalEntities
			self.messageHex = messageHex
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case rawHex = "raw_hex"
			case referencedGlobalEntities = "referenced_global_entities"
			case messageHex = "message_hex"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(rawHex, forKey: .rawHex)
			try container.encode(referencedGlobalEntities, forKey: .referencedGlobalEntities)
			try container.encodeIfPresent(messageHex, forKey: .messageHex)
		}
	}
}
