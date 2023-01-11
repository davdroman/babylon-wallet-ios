import Foundation

// MARK: - EddsaEd25519Signature
public struct EddsaEd25519Signature: ValueProtocol, Sendable, Codable, Hashable {
	// Type name, used as a discriminator
	public static let kind: ValueKind = .eddsaEd25519Signature
	public func embedValue() -> Value_ {
		.eddsaEd25519Signature(self)
	}

	// MARK: Stored properties
	public let bytes: [UInt8]

	// MARK: Init

	public init(bytes: [UInt8]) {
		self.bytes = bytes
	}

	public init(hex: String) throws {
		// TODO: Validation of length of array
		self.init(bytes: try [UInt8](hex: hex))
	}
}

public extension EddsaEd25519Signature {
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case signature, type
	}

	// MARK: Codable
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(Self.kind, forKey: .type)

		try container.encode(bytes.hex(), forKey: .signature)
	}

	init(from decoder: Decoder) throws {
		// Checking for type discriminator
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let kind: ValueKind = try container.decode(ValueKind.self, forKey: .type)
		if kind != Self.kind {
			throw InternalDecodingFailure.valueTypeDiscriminatorMismatch(expected: Self.kind, butGot: kind)
		}

		// Decoding `signature`
		try self.init(hex: container.decode(String.self, forKey: .signature))
	}
}