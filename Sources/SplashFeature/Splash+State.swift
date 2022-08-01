//
//  File.swift
//
//
//  Created by Alexander Cyon on 2022-07-01.
//

import Common
import ComposableArchitecture
import Foundation
import Profile
import ProfileLoader
import Wallet
import WalletLoader

// MARK: - Splash
/// Namespace for SplashFeature
public enum Splash {}

public extension Splash {
	// MARK: State
	struct State: Equatable {
		public init() {}
	}
}