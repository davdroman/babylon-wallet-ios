//
// EcdsaSecp256k1Signature.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - EcdsaSecp256k1Signature
public struct EcdsaSecp256k1Signature: Codable, Hashable {
	public private(set) var keyType: PublicKeyType
	/** A hex-encoded recoverable ECDSA Secp256k1 signature (65 bytes). The first byte is the recovery id, the remaining 64 bytes are the compact signature, ie CONCAT(R, s) where R and s are each 32-bytes in padded big-endian format. */
	public private(set) var signatureHex: String

	public init(keyType: PublicKeyType, signatureHex: String) {
		self.keyType = keyType
		self.signatureHex = signatureHex
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case keyType = "key_type"
		case signatureHex = "signature_hex"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(keyType, forKey: .keyType)
		try container.encode(signatureHex, forKey: .signatureHex)
	}
}