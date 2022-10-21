//
// TransactionLookupIdentifier.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - TransactionLookupIdentifier
public struct TransactionLookupIdentifier: Sendable, Codable, Hashable {
	public let origin: TransactionLookupOrigin
	public let valueHex: String

	public init(origin: TransactionLookupOrigin, valueHex: String) {
		self.origin = origin
		self.valueHex = valueHex
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case origin
		case valueHex = "value_hex"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(origin, forKey: .origin)
		try container.encode(valueHex, forKey: .valueHex)
	}
}