//
// TokenIdentifier.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct TokenIdentifier: Sendable, Codable, Hashable {

    /** The radix resource identifier of the token. */
    public var rri: String

    public init(rri: String) {
        self.rri = rri
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case rri
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rri, forKey: .rri)
    }
}

