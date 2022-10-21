//
// EntityStateResponseNonFungibleResource.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - EntityStateResponseNonFungibleResource
public struct EntityStateResponseNonFungibleResource: Sendable, Codable, Hashable {
	/** The Bech32m-encoded human readable version of the resource's global address */
	public let address: String
	public let amount: Double

	public init(address: String, amount: Double) {
		self.address = address
		self.amount = amount
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case address
		case amount
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(address, forKey: .address)
		try container.encode(amount, forKey: .amount)
	}
}