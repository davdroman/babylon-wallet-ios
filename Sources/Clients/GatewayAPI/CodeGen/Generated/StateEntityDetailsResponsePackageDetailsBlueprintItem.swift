//
// StateEntityDetailsResponsePackageDetailsBlueprintItem.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateEntityDetailsResponsePackageDetailsBlueprintItem")
public typealias StateEntityDetailsResponsePackageDetailsBlueprintItem = GatewayAPI.StateEntityDetailsResponsePackageDetailsBlueprintItem

extension GatewayAPI {

public struct StateEntityDetailsResponsePackageDetailsBlueprintItem: Codable, Hashable {

    public private(set) var name: String
    public private(set) var version: String
    public private(set) var definition: AnyCodable
    public private(set) var dependantEntities: [String]?
    public private(set) var authTemplate: AnyCodable?
    public private(set) var authTemplateIsLocked: Bool?
    public private(set) var royaltyConfig: AnyCodable?
    public private(set) var royaltyConfigIsLocked: Bool?

    public init(name: String, version: String, definition: AnyCodable, dependantEntities: [String]? = nil, authTemplate: AnyCodable? = nil, authTemplateIsLocked: Bool? = nil, royaltyConfig: AnyCodable? = nil, royaltyConfigIsLocked: Bool? = nil) {
        self.name = name
        self.version = version
        self.definition = definition
        self.dependantEntities = dependantEntities
        self.authTemplate = authTemplate
        self.authTemplateIsLocked = authTemplateIsLocked
        self.royaltyConfig = royaltyConfig
        self.royaltyConfigIsLocked = royaltyConfigIsLocked
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case version
        case definition
        case dependantEntities = "dependant_entities"
        case authTemplate = "auth_template"
        case authTemplateIsLocked = "auth_template_is_locked"
        case royaltyConfig = "royalty_config"
        case royaltyConfigIsLocked = "royalty_config_is_locked"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(version, forKey: .version)
        try container.encode(definition, forKey: .definition)
        try container.encodeIfPresent(dependantEntities, forKey: .dependantEntities)
        try container.encodeIfPresent(authTemplate, forKey: .authTemplate)
        try container.encodeIfPresent(authTemplateIsLocked, forKey: .authTemplateIsLocked)
        try container.encodeIfPresent(royaltyConfig, forKey: .royaltyConfig)
        try container.encodeIfPresent(royaltyConfigIsLocked, forKey: .royaltyConfigIsLocked)
    }
}

}
