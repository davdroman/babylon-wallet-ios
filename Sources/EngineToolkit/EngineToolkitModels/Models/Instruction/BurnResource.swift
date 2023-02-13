import Foundation

// MARK: - BurnResource
public struct BurnResource: InstructionProtocol {
	// Type name, used as a discriminator
	public static let kind: InstructionKind = .burnResource
	public func embed() -> Instruction {
		.burnResource(self)
	}

	// MARK: Stored properties

	public let bucket: Bucket

	// MARK: Init

	public init(bucket: Bucket) {
		self.bucket = bucket
	}
}

extension BurnResource {
	// MARK: CodingKeys

	private enum CodingKeys: String, CodingKey {
		case type = "instruction"
		case bucket
	}

	// MARK: Codable

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(Self.kind, forKey: .type)

		try container.encode(bucket, forKey: .bucket)
	}

	public init(from decoder: Decoder) throws {
		// Checking for type discriminator
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let kind: InstructionKind = try container.decode(InstructionKind.self, forKey: .type)
		if kind != Self.kind {
			throw InternalDecodingFailure.instructionTypeDiscriminatorMismatch(expected: Self.kind, butGot: kind)
		}

		try self.init(bucket: container.decode(Bucket.self, forKey: .bucket))
	}
}