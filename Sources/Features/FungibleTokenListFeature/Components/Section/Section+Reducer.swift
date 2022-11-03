import ComposableArchitecture

public extension FungibleTokenList.Section {
	// MARK: Reducer
	typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
	static let reducer = Reducer.combine(
		FungibleTokenList.Row.reducer.forEach(
			state: \.assets,
			action: /FungibleTokenList.Section.Action.asset(id:action:),
			environment: { _ in FungibleTokenList.Row.Environment() }
		),

		Reducer { _, action, _ in
			switch action {
			case .internal:
				return .none
			case .coordinate:
				return .none
			case let .asset(id: id, action: action):
				return .none
			}
		}
	)
}