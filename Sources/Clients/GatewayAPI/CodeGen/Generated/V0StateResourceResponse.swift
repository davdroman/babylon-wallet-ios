//
// V0StateResourceResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - V0StateResourceResponse
public struct V0StateResourceResponse: Codable, Hashable {
	public private(set) var manager: Substate

	public init(manager: Substate) {
		self.manager = manager
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case manager
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(manager, forKey: .manager)
	}
}