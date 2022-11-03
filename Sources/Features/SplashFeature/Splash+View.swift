import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - Splash.View
public extension Splash {
	struct View: SwiftUI.View {
		public typealias Store = ComposableArchitecture.Store<State, Action>
		private let store: Store

		public init(store: Store) {
			self.store = store
		}
	}
}

public extension Splash.View {
	var body: some View {
		WithViewStore(
			store,
			observe: ViewState.init(state:),
			send: Splash.Action.init
		) { viewStore in
			ForceFullScreen {
				VStack {
					Text("Splash")
				}
			}
			.onAppear {
				viewStore.send(.viewDidAppear)
			}
		}
	}
}

// MARK: - Splash.View.ViewState
extension Splash.View {
	// MARK: ViewState
	struct ViewState: Equatable {
		init(state _: Splash.State) {}
	}
}

// MARK: - Splash.View.ViewAction
extension Splash.View {
	// MARK: ViewAction
	enum ViewAction {
		case viewDidAppear
	}
}

extension Splash.Action {
	init(action: Splash.View.ViewAction) {
		switch action {
		case .viewDidAppear:
			self = .internal(.system(.viewDidAppear))
		}
	}
}

#if DEBUG

// MARK: - SplashView_Previews
struct SplashView_Previews: PreviewProvider {
	static var previews: some View {
		Splash.View(
			store: .init(
				initialState: .init(),
				reducer: Splash.reducer,
				environment: .init(
					backgroundQueue: .immediate,
					mainQueue: .immediate,
					profileLoader: .unimplemented
				)
			)
		)
	}
}
#endif // DEBUG