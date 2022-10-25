//
// V0StateComponentDescendentId.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - V0StateComponentDescendentId
public struct V0StateComponentDescendentId: Codable, Hashable {
	public private(set) var parent: SubstateId
	public private(set) var entityId: EntityId
	/** Depth under component */
	public private(set) var depth: Int

	public init(parent: SubstateId, entityId: EntityId, depth: Int) {
		self.parent = parent
		self.entityId = entityId
		self.depth = depth
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case parent
		case entityId = "entity_id"
		case depth
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(parent, forKey: .parent)
		try container.encode(entityId, forKey: .entityId)
		try container.encode(depth, forKey: .depth)
	}
}
