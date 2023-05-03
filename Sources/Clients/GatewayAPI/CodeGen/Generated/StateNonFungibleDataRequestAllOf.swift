//
// StateNonFungibleDataRequestAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateNonFungibleDataRequestAllOf")
public typealias StateNonFungibleDataRequestAllOf = GatewayAPI.StateNonFungibleDataRequestAllOf

extension GatewayAPI {

public struct StateNonFungibleDataRequestAllOf: Codable, Hashable {

    /** Bech32m-encoded human readable version of the resource (fungible, non-fungible) global address or hex-encoded id. */
    public private(set) var resourceAddress: String
    public private(set) var nonFungibleIds: [String]

    public init(resourceAddress: String, nonFungibleIds: [String]) {
        self.resourceAddress = resourceAddress
        self.nonFungibleIds = nonFungibleIds
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case resourceAddress = "resource_address"
        case nonFungibleIds = "non_fungible_ids"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(resourceAddress, forKey: .resourceAddress)
        try container.encode(nonFungibleIds, forKey: .nonFungibleIds)
    }
}

}