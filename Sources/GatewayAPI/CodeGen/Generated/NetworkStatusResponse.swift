//
// NetworkStatusResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - NetworkStatusResponse
public struct NetworkStatusResponse: Codable, Hashable {
	public private(set) var preGenesisStateIdentifier: CommittedStateIdentifier
	public private(set) var postGenesisStateIdentifier: CommittedStateIdentifier
	public private(set) var currentStateIdentifier: CommittedStateIdentifier

	public init(preGenesisStateIdentifier: CommittedStateIdentifier, postGenesisStateIdentifier: CommittedStateIdentifier, currentStateIdentifier: CommittedStateIdentifier) {
		self.preGenesisStateIdentifier = preGenesisStateIdentifier
		self.postGenesisStateIdentifier = postGenesisStateIdentifier
		self.currentStateIdentifier = currentStateIdentifier
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case preGenesisStateIdentifier = "pre_genesis_state_identifier"
		case postGenesisStateIdentifier = "post_genesis_state_identifier"
		case currentStateIdentifier = "current_state_identifier"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(preGenesisStateIdentifier, forKey: .preGenesisStateIdentifier)
		try container.encode(postGenesisStateIdentifier, forKey: .postGenesisStateIdentifier)
		try container.encode(currentStateIdentifier, forKey: .currentStateIdentifier)
	}
}