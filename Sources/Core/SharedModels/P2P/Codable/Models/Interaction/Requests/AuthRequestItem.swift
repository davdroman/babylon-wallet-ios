import Prelude

// MARK: - P2P.FromDapp.WalletInteraction.AuthRequestItem
public extension P2P.FromDapp.WalletInteraction {
	enum AuthRequestItem: Sendable, Hashable, Decodable {
		private enum CodingKeys: String, CodingKey {
			case discriminator
		}

		enum Discriminator: String, Decodable {
			case login
			case usePersona
		}

		case login(AuthLoginRequestItem)
		case usePersona(AuthUsePersonaRequestItem)

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			let discriminator = try container.decode(Discriminator.self, forKey: .discriminator)
			switch discriminator {
			case .login:
				self = .login(try .init(from: decoder))
			case .usePersona:
				self = .usePersona(try .init(from: decoder))
			}
		}
	}
}

// MARK: - P2P.FromDapp.WalletInteraction.AuthLoginRequestItem
public extension P2P.FromDapp.WalletInteraction {
	struct AuthLoginRequestItem: Sendable, Hashable, Decodable {
		public let challenge: String?

		public init(challenge: String?) {
			self.challenge = challenge
		}
	}
}

// MARK: - P2P.FromDapp.WalletInteraction.AuthUsePersonaRequestItem
public extension P2P.FromDapp.WalletInteraction {
	struct AuthUsePersonaRequestItem: Sendable, Hashable, Decodable {
		public let identityAddress: String

		public init(identityAddress: String) {
			self.identityAddress = identityAddress
		}
	}
}