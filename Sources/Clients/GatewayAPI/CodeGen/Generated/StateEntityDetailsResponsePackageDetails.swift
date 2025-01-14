//
// StateEntityDetailsResponsePackageDetails.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.StateEntityDetailsResponsePackageDetails")
public typealias StateEntityDetailsResponsePackageDetails = GatewayAPI.StateEntityDetailsResponsePackageDetails

extension GatewayAPI {

public struct StateEntityDetailsResponsePackageDetails: Codable, Hashable {

    public private(set) var type: StateEntityDetailsResponseItemDetailsType
    public private(set) var vmType: PackageVmType
    /** Hex-encoded binary blob. */
    public private(set) var codeHashHex: String
    /** Hex-encoded binary blob. */
    public private(set) var codeHex: String
    /** String-encoded decimal representing the amount of a related fungible resource. */
    public private(set) var royaltyVaultBalance: String?
    public private(set) var blueprints: StateEntityDetailsResponsePackageDetailsBlueprintCollection?
    public private(set) var schemas: StateEntityDetailsResponsePackageDetailsSchemaCollection?

    public init(type: StateEntityDetailsResponseItemDetailsType, vmType: PackageVmType, codeHashHex: String, codeHex: String, royaltyVaultBalance: String? = nil, blueprints: StateEntityDetailsResponsePackageDetailsBlueprintCollection? = nil, schemas: StateEntityDetailsResponsePackageDetailsSchemaCollection? = nil) {
        self.type = type
        self.vmType = vmType
        self.codeHashHex = codeHashHex
        self.codeHex = codeHex
        self.royaltyVaultBalance = royaltyVaultBalance
        self.blueprints = blueprints
        self.schemas = schemas
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case vmType = "vm_type"
        case codeHashHex = "code_hash_hex"
        case codeHex = "code_hex"
        case royaltyVaultBalance = "royalty_vault_balance"
        case blueprints
        case schemas
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(vmType, forKey: .vmType)
        try container.encode(codeHashHex, forKey: .codeHashHex)
        try container.encode(codeHex, forKey: .codeHex)
        try container.encodeIfPresent(royaltyVaultBalance, forKey: .royaltyVaultBalance)
        try container.encodeIfPresent(blueprints, forKey: .blueprints)
        try container.encodeIfPresent(schemas, forKey: .schemas)
    }
}

}
