//
// GlobalEntityId.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - GlobalEntityId
public struct GlobalEntityId: Codable, Hashable {
	public private(set) var entityType: EntityType
	/** The hex-encoded bytes of the entity address */
	public private(set) var entityAddressHex: String
	/** The hex-encoded bytes of the entity's global address. This is currently the same as entity_address, but may change in future. */
	public private(set) var globalAddressHex: String
	/** The Bech32m-encoded human readable version of the entity's global address */
	public private(set) var globalAddress: String

	public init(entityType: EntityType, entityAddressHex: String, globalAddressHex: String, globalAddress: String) {
		self.entityType = entityType
		self.entityAddressHex = entityAddressHex
		self.globalAddressHex = globalAddressHex
		self.globalAddress = globalAddress
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case entityType = "entity_type"
		case entityAddressHex = "entity_address_hex"
		case globalAddressHex = "global_address_hex"
		case globalAddress = "global_address"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(entityType, forKey: .entityType)
		try container.encode(entityAddressHex, forKey: .entityAddressHex)
		try container.encode(globalAddressHex, forKey: .globalAddressHex)
		try container.encode(globalAddress, forKey: .globalAddress)
	}
}