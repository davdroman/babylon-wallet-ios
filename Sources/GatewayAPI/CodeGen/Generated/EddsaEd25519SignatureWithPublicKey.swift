//
// EddsaEd25519SignatureWithPublicKey.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - EddsaEd25519SignatureWithPublicKey
/** The EDDSA public key and signature */
public struct EddsaEd25519SignatureWithPublicKey: Codable, Hashable {
	public private(set) var keyType: PublicKeyType
	public private(set) var publicKey: EddsaEd25519PublicKey
	public private(set) var signature: EddsaEd25519Signature

	public init(keyType: PublicKeyType, publicKey: EddsaEd25519PublicKey, signature: EddsaEd25519Signature) {
		self.keyType = keyType
		self.publicKey = publicKey
		self.signature = signature
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case keyType = "key_type"
		case publicKey = "public_key"
		case signature
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(keyType, forKey: .keyType)
		try container.encode(publicKey, forKey: .publicKey)
		try container.encode(signature, forKey: .signature)
	}
}
