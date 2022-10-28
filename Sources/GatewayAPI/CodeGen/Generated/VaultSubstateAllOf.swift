//
// VaultSubstateAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - VaultSubstateAllOf
public struct VaultSubstateAllOf: Codable, Hashable {
	public private(set) var resourceAmount: ResourceAmount

	public init(resourceAmount: ResourceAmount) {
		self.resourceAmount = resourceAmount
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case resourceAmount = "resource_amount"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(resourceAmount, forKey: .resourceAmount)
	}
}