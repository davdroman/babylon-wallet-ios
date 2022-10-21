//
// GatewayResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - GatewayResponse
public struct GatewayResponse: Sendable, Codable, Hashable {
	public let gatewayApi: GatewayApiVersions
	public let ledgerState: LedgerState
	public let targetLedgerState: TargetLedgerState?

	public init(gatewayApi: GatewayApiVersions, ledgerState: LedgerState, targetLedgerState: TargetLedgerState? = nil) {
		self.gatewayApi = gatewayApi
		self.ledgerState = ledgerState
		self.targetLedgerState = targetLedgerState
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case gatewayApi = "gateway_api"
		case ledgerState = "ledger_state"
		case targetLedgerState = "target_ledger_state"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(gatewayApi, forKey: .gatewayApi)
		try container.encode(ledgerState, forKey: .ledgerState)
		try container.encodeIfPresent(targetLedgerState, forKey: .targetLedgerState)
	}
}