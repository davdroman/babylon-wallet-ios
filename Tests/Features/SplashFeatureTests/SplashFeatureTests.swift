import FeaturePrelude
import LocalAuthenticationClient
import Profile
import ProfileLoader
@testable import SplashFeature
import TestUtils

// MARK: - SplashFeatureTests
@MainActor
final class SplashFeatureTests: TestCase {
	func test__GIVEN__splash_appeared__WHEN__no_biometrics_config__THEN__alert_is_shown() async throws {
		let authBiometricsConfig = LocalAuthenticationConfig.neitherBiometricsNorPasscodeSetUp

		let testScheduler = DispatchQueue.test
		let store = TestStore(
			initialState: Splash.State(),
			reducer: Splash()
		)

		store.dependencies.localAuthenticationClient = LocalAuthenticationClient {
			authBiometricsConfig
		}

		store.dependencies.mainQueue = testScheduler.eraseToAnyScheduler()
		store.dependencies.platformEnvironmentClient.isSimulator = { false }

		let newProfile = try await Profile.new(networkAndGateway: .hammunet, mnemonic: .generate())
		store.dependencies.profileLoader = ProfileLoader(loadProfile: {
			.success(newProfile)
		})

		// when
		await store.send(.internal(.view(.viewAppeared)))

		// then
		await store.receive(.internal(.system(.loadProfileResult(.success(newProfile))))) {
			$0.profileResult = .success(newProfile)
		}
		await testScheduler.advance(by: .seconds(0.2))
		await store.receive(.internal(.system(.biometricsConfigResult(.success(authBiometricsConfig))))) {
			$0.biometricsCheckFailedAlert = .init(
				title: { .init(L10n.Splash.Alert.BiometricsCheckFailed.title) },
				actions: {
					ButtonState(
						role: .cancel,
						action: .send(.cancelButtonTapped),
						label: { TextState(L10n.Splash.Alert.BiometricsCheckFailed.cancelButtonTitle) }
					)
					ButtonState(
						role: .none,
						action: .send(.openSettingsButtonTapped),
						label: { TextState(L10n.Splash.Alert.BiometricsCheckFailed.settingsButtonTitle) }
					)
				},
				message: { .init(L10n.Splash.Alert.BiometricsCheckFailed.message) }
			)
		}
	}

	func test__GIVEN__splash_appeared__WHEN__biometrics_configured__THEN__notifies_delegate_with_profile_result() async throws {
		/// Profile load success
		let newProfile = try await Profile.new(networkAndGateway: .hammunet, mnemonic: .generate())
		try await assertNotifiesDelegateWithProfileResult(.success(newProfile))
		try await assertNotifiesDelegateWithProfileResult(.success(nil))

		/// Profile load failure
		try await assertNotifiesDelegateWithProfileResult(
			.failure(.profileVersionOutdated(json: Data(), version: .minimum))
		)
		try await assertNotifiesDelegateWithProfileResult(
			.failure(.failedToCreateProfileFromSnapshot(.init(version: .minimum, error: NSError.any)))
		)
		try await assertNotifiesDelegateWithProfileResult(
			.failure(.decodingFailure(json: Data(), .unknown(.init(error: NSError.any))))
		)
	}

	func assertNotifiesDelegateWithProfileResult(_ result: ProfileLoader.ProfileResult) async throws {
		let authBiometricsConfig = LocalAuthenticationConfig.biometricsAndPasscodeSetUp
		let testScheduler = DispatchQueue.test
		let store = TestStore(
			initialState: Splash.State(),
			reducer: Splash()
		)

		store.dependencies.localAuthenticationClient = LocalAuthenticationClient {
			authBiometricsConfig
		}

		store.dependencies.mainQueue = testScheduler.eraseToAnyScheduler()

		store.dependencies.profileLoader = ProfileLoader(loadProfile: {
			result
		})

		// when
		await store.send(.internal(.view(.viewAppeared)))

		// then
		await store.receive(.internal(.system(.loadProfileResult(result)))) {
			$0.profileResult = result
		}
		await testScheduler.advance(by: .seconds(0.2))
		await store.receive(.internal(.system(.biometricsConfigResult(.success(authBiometricsConfig)))))
		await store.receive(.delegate(.profileResultLoaded(result)))
	}
}

extension NSError {
	static var any: NSError {
		NSError(domain: "Test", code: -1000)
	}
}
