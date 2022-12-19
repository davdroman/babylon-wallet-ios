//
// EntityResourcesRequestAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.EntityResourcesRequestAllOf")
public typealias EntityResourcesRequestAllOf = GatewayAPI.EntityResourcesRequestAllOf

// MARK: - GatewayAPI.EntityResourcesRequestAllOf
public extension GatewayAPI {
	struct EntityResourcesRequestAllOf: Codable, Hashable {
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var address: String

		public init(address: String) {
			self.address = address
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case address
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(address, forKey: .address)
		}
	}
}