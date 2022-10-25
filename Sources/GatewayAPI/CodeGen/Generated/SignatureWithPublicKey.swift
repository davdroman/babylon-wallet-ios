//
// SignatureWithPublicKey.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - SignatureWithPublicKey
public enum SignatureWithPublicKey: Codable, JSONEncodable, Hashable {
	case typeEcdsaSecp256k1SignatureWithPublicKey(EcdsaSecp256k1SignatureWithPublicKey)
	case typeEddsaEd25519SignatureWithPublicKey(EddsaEd25519SignatureWithPublicKey)

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case let .typeEcdsaSecp256k1SignatureWithPublicKey(value):
			try container.encode(value)
		case let .typeEddsaEd25519SignatureWithPublicKey(value):
			try container.encode(value)
		}
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let value = try? container.decode(EcdsaSecp256k1SignatureWithPublicKey.self) {
			self = .typeEcdsaSecp256k1SignatureWithPublicKey(value)
		} else if let value = try? container.decode(EddsaEd25519SignatureWithPublicKey.self) {
			self = .typeEddsaEd25519SignatureWithPublicKey(value)
		} else {
			throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of SignatureWithPublicKey"))
		}
	}
}
