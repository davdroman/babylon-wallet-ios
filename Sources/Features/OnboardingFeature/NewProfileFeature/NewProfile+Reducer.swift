import ComposableArchitecture
import KeychainClient
import Mnemonic
import Profile
import ProfileClient

// MARK: - MnemonicGenerator
public typealias MnemonicGenerator = (BIP39.WordCount, BIP39.Language) throws -> Mnemonic

// MARK: - MnemonicGeneratorKey
private enum MnemonicGeneratorKey: DependencyKey {
	typealias Value = MnemonicGenerator
	static let liveValue = { try Mnemonic(wordCount: $0, language: $1) }
}

public extension DependencyValues {
	var mnemonicGenerator: MnemonicGenerator {
		get { self[MnemonicGeneratorKey.self] }
		set { self[MnemonicGeneratorKey.self] = newValue }
	}
}

// MARK: - NewProfile
public struct NewProfile: ReducerProtocol {
	@Dependency(\.mnemonicGenerator) var mnemonicGenerator
	@Dependency(\.keychainClient) var keychainClient
	@Dependency(\.profileClient) var profileClient
}

public extension NewProfile {
	func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
		switch action {
		case .internal(.user(.goBack)):
			return .run { send in
				await send(.coordinate(.goBack))
			}

		case .internal(.user(.createProfile)):
			return .run { send in
				await send(.internal(.system(.createProfile)))
			}

		case .internal(.system(.createProfile)):
			precondition(state.canProceed)
			precondition(!state.isCreatingProfile)
			state.isCreatingProfile = true
			return .run { [mnemonicGenerator, nameOfFirstAccount = state.nameOfFirstAccount] send in

				await send(.internal(.system(.createdProfileResult(
					TaskResult {
						let curve25519FactorSourceMnemonic = try mnemonicGenerator(BIP39.WordCount.twentyFour, BIP39.Language.english)

						let newProfileRequest = CreateNewProfileRequest(
							curve25519FactorSourceMnemonic: curve25519FactorSourceMnemonic,
							createFirstAccountRequest: .init(
								accountName: nameOfFirstAccount
							)
						)
						let newProfile = try await profileClient.createNewProfile(newProfileRequest)

						let curve25519FactorSourceReference = newProfile.factorSources.curve25519OnDeviceStoredMnemonicHierarchicalDeterministicSLIP10FactorSources.first.reference

						try keychainClient.saveFactorSource(
							mnemonic: curve25519FactorSourceMnemonic,
							reference: curve25519FactorSourceReference
						)

						try keychainClient.saveProfile(profile: newProfile)

						return newProfile
					}
				))))
			}

		case let .internal(.system(.createdProfileResult(.success(profile)))):
			state.isCreatingProfile = false
			return .run { send in
				await send(.coordinate(.finishedCreatingNewProfile(profile)))
			}

		case let .internal(.system(.createdProfileResult(.failure(error)))):
			state.isCreatingProfile = false
			return .run { send in
				await send(.coordinate(.failedToCreateNewProfile(reason: String(describing: error))))
			}

		case let .internal(.user(.accountNameChanged(accountName))):
			state.nameOfFirstAccount = accountName
			state.canProceed = !state.nameOfFirstAccount.isEmpty
			return .none

		case .coordinate:
			return .none
		}
	}
}