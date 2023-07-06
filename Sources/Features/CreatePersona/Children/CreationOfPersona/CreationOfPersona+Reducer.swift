import Cryptography
import DerivePublicKeysFeature
import FeaturePrelude
import PersonasClient

public struct CreationOfPersona: Sendable, FeatureReducer {
	public struct State: Sendable, Hashable {
		public let name: NonEmptyString
		public let personaData: PersonaData
		public var derivePublicKeys: DerivePublicKeys.State

		public init(
			name: NonEmptyString,
			personaData: PersonaData? = nil
		) {
			self.name = name
			#if DEBUG
			// FIXME: REMOVE THIS TEMPORARY SETTING OF PERSONA DATA!
			self.personaData = .previewValue
			#else
			self.personaData = .init()
			#endif
			self.derivePublicKeys = .init(
				derivationPathOption: .nextBasedOnFactorSource(
					networkOption: .useCurrent,
					entityKind: .identity,
					curve: .curve25519
				),
				factorSourceOption: .device,
				purpose: .createEntity
			)
		}
	}

	public enum InternalAction: Sendable, Equatable {
		case createPersonaResult(TaskResult<Profile.Network.Persona>)
	}

	public enum ChildAction: Sendable, Equatable {
		case derivePublicKeys(DerivePublicKeys.Action)
	}

	public enum DelegateAction: Sendable, Equatable {
		case createdPersona(Profile.Network.Persona)
		case createPersonaFailed
	}

	@Dependency(\.errorQueue) var errorQueue
	@Dependency(\.personasClient) var personasClient

	public init() {}

	public var body: some ReducerProtocolOf<Self> {
		Scope(
			state: \.derivePublicKeys,
			action: /Action.child .. ChildAction.derivePublicKeys
		) {
			DerivePublicKeys()
		}

		Reduce(core)
	}

	public func reduce(into state: inout State, internalAction: InternalAction) -> EffectTask<Action> {
		switch internalAction {
		case let .createPersonaResult(.failure(error)):
			errorQueue.schedule(error)
			return .send(.delegate(.createPersonaFailed))

		case let .createPersonaResult(.success(persona)):
			return .send(.delegate(.createdPersona(persona)))
		}
	}

	public func reduce(into state: inout State, childAction: ChildAction) -> EffectTask<Action> {
		switch childAction {
		case let .derivePublicKeys(.delegate(.derivedPublicKeys(
			hdKeys,
			factorSourceID,
			networkID
		))):
			guard let hdKey = hdKeys.first else {
				loggerGlobal.error("Failed to create persona expected one single key, got: \(hdKeys.count)")
				return .send(.delegate(.createPersonaFailed))
			}
			return .run { [name = state.name, personaData = state.personaData] send in

				let persona = try Profile.Network.Persona(
					networkID: networkID,
					factorInstance: .init(
						factorSourceID: factorSourceID,
						publicKey: hdKey.publicKey,
						derivationPath: hdKey.derivationPath
					),
					displayName: name,
					extraProperties: .init(personaData: personaData)
				)

				await send(.internal(.createPersonaResult(
					TaskResult {
						try await personasClient.saveVirtualPersona(persona)
						return persona
					}
				)))
			} catch: { error, send in
				loggerGlobal.error("Failed to create persona, error: \(error)")
				await send(.delegate(.createPersonaFailed))
			}
		case .derivePublicKeys(.delegate(.failedToDerivePublicKey)):
			return .send(.delegate(.createPersonaFailed))

		default: return .none
		}
	}
}
