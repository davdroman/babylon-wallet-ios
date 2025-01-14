//
// StateEntityNonFungibleResourceVaultsPageOptIns.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateEntityNonFungibleResourceVaultsPageOptIns")
public typealias StateEntityNonFungibleResourceVaultsPageOptIns = GatewayAPI.StateEntityNonFungibleResourceVaultsPageOptIns

extension GatewayAPI {

public struct StateEntityNonFungibleResourceVaultsPageOptIns: Codable, Hashable {

    public private(set) var nonFungibleIncludeNfids: Bool?

    public init(nonFungibleIncludeNfids: Bool? = nil) {
        self.nonFungibleIncludeNfids = nonFungibleIncludeNfids
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case nonFungibleIncludeNfids = "non_fungible_include_nfids"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(nonFungibleIncludeNfids, forKey: .nonFungibleIncludeNfids)
    }
}

}
