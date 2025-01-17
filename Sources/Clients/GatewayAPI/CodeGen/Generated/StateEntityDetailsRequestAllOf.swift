//
// StateEntityDetailsRequestAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateEntityDetailsRequestAllOf")
public typealias StateEntityDetailsRequestAllOf = GatewayAPI.StateEntityDetailsRequestAllOf

extension GatewayAPI {

public struct StateEntityDetailsRequestAllOf: Codable, Hashable {

    public private(set) var optIns: StateEntityDetailsOptIns?
    public private(set) var addresses: [String]
    public private(set) var aggregationLevel: ResourceAggregationLevel?

    public init(optIns: StateEntityDetailsOptIns? = nil, addresses: [String], aggregationLevel: ResourceAggregationLevel? = nil) {
        self.optIns = optIns
        self.addresses = addresses
        self.aggregationLevel = aggregationLevel
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case optIns = "opt_ins"
        case addresses
        case aggregationLevel = "aggregation_level"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(optIns, forKey: .optIns)
        try container.encode(addresses, forKey: .addresses)
        try container.encodeIfPresent(aggregationLevel, forKey: .aggregationLevel)
    }
}

}
