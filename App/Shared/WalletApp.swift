import AppFeature
import ComposableArchitecture
import SwiftUI
import UserDefaultsClient

typealias App = AppFeature.App

public extension App.Environment {
	static let live: Self = {
		let userDefaultsClient: UserDefaultsClient = .live()

		return Self(
			backgroundQueue: DispatchQueue(label: "background-queue").eraseToAnyScheduler(),
			mainQueue: .main,
			profileLoader: .live(userDefaultsClient: userDefaultsClient),
			userDefaultsClient: userDefaultsClient,
			walletLoader: .live
		)

	}()
}

// MARK: - WalletApp
@main
struct WalletApp: SwiftUI.App {
	let store: Store

	init() {
		store = Store(
			initialState: .init(),
			reducer: App.reducer,
			environment: .live
		)
	}

	var body: some Scene {
		WindowGroup {
			App.Coordinator(store: store)
				.textFieldStyle(.roundedBorder)
				.buttonStyle(.borderedProminent)

			#if os(macOS)
				.frame(minWidth: 1020, maxWidth: .infinity, minHeight: 512, maxHeight: .infinity)
			#endif

			// FIXME: Move to Settings
			// Text("Version: \(Bundle.main.appVersionLong) build #\(Bundle.main.appBuild)")
		}
	}
}

extension WalletApp {
	typealias Store = ComposableArchitecture.Store<App.State, App.Action>
}
