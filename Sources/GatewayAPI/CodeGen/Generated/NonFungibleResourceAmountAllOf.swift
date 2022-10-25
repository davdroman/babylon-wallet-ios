//
// NonFungibleResourceAmountAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - NonFungibleResourceAmountAllOf
public struct NonFungibleResourceAmountAllOf: Codable, Hashable {
	public private(set) var nfIdsHex: [String]

	public init(nfIdsHex: [String]) {
		self.nfIdsHex = nfIdsHex
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case nfIdsHex = "nf_ids_hex"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(nfIdsHex, forKey: .nfIdsHex)
	}
}
