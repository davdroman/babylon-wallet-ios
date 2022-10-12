//
// EntityDetailsResponseDetails.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public enum EntityDetailsResponseDetails: Sendable, Codable, Hashable {
    case typeEntityDetailsResponseFungibleDetails(EntityDetailsResponseFungibleDetails)
    case typeEntityDetailsResponseNonFungibleDetails(EntityDetailsResponseNonFungibleDetails)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeEntityDetailsResponseFungibleDetails(let value):
            try container.encode(value)
        case .typeEntityDetailsResponseNonFungibleDetails(let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(EntityDetailsResponseFungibleDetails.self) {
            self = .typeEntityDetailsResponseFungibleDetails(value)
        } else if let value = try? container.decode(EntityDetailsResponseNonFungibleDetails.self) {
            self = .typeEntityDetailsResponseNonFungibleDetails(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of EntityDetailsResponseDetails"))
        }
    }
}

