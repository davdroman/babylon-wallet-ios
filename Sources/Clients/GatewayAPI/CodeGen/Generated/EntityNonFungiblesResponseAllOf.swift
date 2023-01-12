//
// EntityNonFungiblesResponseAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import ClientPrelude
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.EntityNonFungiblesResponseAllOf")
public typealias EntityNonFungiblesResponseAllOf = GatewayAPI.EntityNonFungiblesResponseAllOf

// MARK: - GatewayAPI.EntityNonFungiblesResponseAllOf
public extension GatewayAPI {
	struct EntityNonFungiblesResponseAllOf: Codable, Hashable {
		/** The Bech32m-encoded human readable version of the entity's global address. */
		public private(set) var address: String
		public private(set) var nonFungibles: NonFungibleResourcesCollection

		public init(address: String, nonFungibles: NonFungibleResourcesCollection) {
			self.address = address
			self.nonFungibles = nonFungibles
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case address
			case nonFungibles = "non_fungibles"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(address, forKey: .address)
			try container.encode(nonFungibles, forKey: .nonFungibles)
		}
	}
}
