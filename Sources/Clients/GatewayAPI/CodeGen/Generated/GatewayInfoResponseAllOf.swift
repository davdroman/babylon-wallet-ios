//
// GatewayInfoResponseAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.GatewayInfoResponseAllOf")
public typealias GatewayInfoResponseAllOf = GatewayAPI.GatewayInfoResponseAllOf

// MARK: - GatewayAPI.GatewayInfoResponseAllOf
public extension GatewayAPI {
	struct GatewayInfoResponseAllOf: Codable, Hashable {
		public private(set) var knownTarget: GatewayInfoResponseKnownTarget
		public private(set) var releaseInfo: GatewayInfoResponseReleaseInfo

		public init(knownTarget: GatewayInfoResponseKnownTarget, releaseInfo: GatewayInfoResponseReleaseInfo) {
			self.knownTarget = knownTarget
			self.releaseInfo = releaseInfo
		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case knownTarget = "known_target"
			case releaseInfo = "release_info"
		}

		// Encodable protocol methods

		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(knownTarget, forKey: .knownTarget)
			try container.encode(releaseInfo, forKey: .releaseInfo)
		}
	}
}