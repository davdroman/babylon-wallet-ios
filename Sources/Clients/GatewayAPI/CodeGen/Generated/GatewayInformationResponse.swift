//
// GatewayInformationResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.GatewayInformationResponse")
public typealias GatewayInformationResponse = GatewayAPI.GatewayInformationResponse

// MARK: - GatewayAPI.GatewayInformationResponse
public extension GatewayAPI {
	struct GatewayInformationResponse: Codable, Hashable {
		public private(set) var ledgerState: LedgerState
		public private(set) var knownTarget: GatewayInfoResponseKnownTarget
		public private(set) var releaseInfo: GatewayInfoResponseReleaseInfo
		public private(set) var wellKnownAddresses: GatewayInformationResponseAllOfWellKnownAddresses

		public init(ledgerState: LedgerState, knownTarget: GatewayInfoResponseKnownTarget, releaseInfo: GatewayInfoResponseReleaseInfo, wellKnownAddresses: GatewayInformationResponseAllOfWellKnownAddresses) {
			self.ledgerState = ledgerState
			self.knownTarget = knownTarget
			self.releaseInfo = releaseInfo
			self.wellKnownAddresses = wellKnownAddresses
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case ledgerState = "ledger_state"
			case knownTarget = "known_target"
			case releaseInfo = "release_info"
			case wellKnownAddresses = "well_known_addresses"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(ledgerState, forKey: .ledgerState)
			try container.encode(knownTarget, forKey: .knownTarget)
			try container.encode(releaseInfo, forKey: .releaseInfo)
			try container.encode(wellKnownAddresses, forKey: .wellKnownAddresses)
		}
	}
}