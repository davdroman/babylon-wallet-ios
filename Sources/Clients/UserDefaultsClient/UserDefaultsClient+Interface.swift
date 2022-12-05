import Foundation

// MARK: - UserDefaultsClient
public typealias Key = String

// MARK: - UserDefaultsClient
public struct UserDefaultsClient: Sendable {
	public var stringForKey: @Sendable (Key) -> String?
	public var boolForKey: @Sendable (Key) -> Bool
	public var dataForKey: @Sendable (Key) -> Data?
	public var doubleForKey: @Sendable (Key) -> Double
	public var integerForKey: @Sendable (Key) -> Int
	public var remove: @Sendable (Key) async -> Void
	public var setString: @Sendable (String, Key) async -> Void
	public var setBool: @Sendable (Bool, Key) async -> Void
	public var setData: @Sendable (Data?, Key) async -> Void
	public var setDouble: @Sendable (Double, Key) async -> Void
	public var setInteger: @Sendable (Int, Key) async -> Void
}

public extension UserDefaultsClient {
	var hasShownFirstLaunchOnboarding: Bool {
		boolForKey(hasShownFirstLaunchOnboardingKey)
	}

	func setHasShownFirstLaunchOnboarding(_ bool: Bool) async {
		await setBool(bool, hasShownFirstLaunchOnboardingKey)
	}
}

let hasShownFirstLaunchOnboardingKey = "hasShownFirstLaunchOnboardingKey"
