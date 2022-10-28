//
// EcdsaSecp256k1SignatureWithPublicKey.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - EcdsaSecp256k1SignatureWithPublicKey
/** Because ECDSA has recoverable signatures, this only includes a signature */
public struct EcdsaSecp256k1SignatureWithPublicKey: Codable, Hashable {
	public private(set) var keyType: PublicKeyType
	public private(set) var recoverableSignature: EcdsaSecp256k1Signature

	public init(keyType: PublicKeyType, recoverableSignature: EcdsaSecp256k1Signature) {
		self.keyType = keyType
		self.recoverableSignature = recoverableSignature
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case keyType = "key_type"
		case recoverableSignature = "recoverable_signature"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(keyType, forKey: .keyType)
		try container.encode(recoverableSignature, forKey: .recoverableSignature)
	}
}