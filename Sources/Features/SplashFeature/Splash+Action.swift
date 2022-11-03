import ComposableArchitecture
import Profile

// MARK: - Splash.Action
public extension Splash {
	// MARK: Action
	enum Action: Equatable {
		case `internal`(InternalAction)
		case coordinate(CoordinatingAction)
	}
}

// MARK: - SplashLoadProfileResult
public enum SplashLoadProfileResult: Equatable {
	case profileLoaded(Profile)
	case noProfile(reason: String, failedToDecode: Bool)
}

// MARK: - Splash.Action.CoordinatingAction
public extension Splash.Action {
	enum CoordinatingAction: Equatable {
		case loadProfileResult(SplashLoadProfileResult)
	}
}

// MARK: - Splash.Action.InternalAction
public extension Splash.Action {
	enum InternalAction: Equatable {
		/// So we can use a single exit path, and `delay` to display this Splash for at
		/// least 500 ms or suitable time
		case coordinate(CoordinatingAction)

		case system(SystemAction)
	}
}

// MARK: - Splash.Action.InternalAction.SystemAction
public extension Splash.Action.InternalAction {
	enum SystemAction: Equatable {
		case loadProfile
		case loadProfileResult(TaskResult<Profile?>)

		case viewDidAppear
	}
}