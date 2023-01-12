//
// TransactionCommittedDetailsRequestIdentifierType.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import ClientPrelude
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "GatewayAPI.TransactionCommittedDetailsRequestIdentifierType")
public typealias TransactionCommittedDetailsRequestIdentifierType = GatewayAPI.TransactionCommittedDetailsRequestIdentifierType

// MARK: - GatewayAPI.TransactionCommittedDetailsRequestIdentifierType
public extension GatewayAPI {
	enum TransactionCommittedDetailsRequestIdentifierType: String, Codable, CaseIterable {
		case intentHash = "intent_hash"
		case signedIntentHash = "signed_intent_hash"
		case payloadHash = "payload_hash"
	}
}
