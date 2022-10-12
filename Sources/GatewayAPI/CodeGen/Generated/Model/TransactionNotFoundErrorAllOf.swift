//
// TransactionNotFoundErrorAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct TransactionNotFoundErrorAllOf: Sendable, Codable, Hashable {

    public var transactionNotFound: TransactionLookupIdentifier

    public init(transactionNotFound: TransactionLookupIdentifier) {
        self.transactionNotFound = transactionNotFound
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case transactionNotFound = "transaction_not_found"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transactionNotFound, forKey: .transactionNotFound)
    }
}

