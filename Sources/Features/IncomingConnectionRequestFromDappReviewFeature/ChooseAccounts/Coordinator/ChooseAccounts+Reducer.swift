import Collections
import ComposableArchitecture
import NonEmpty
import Profile

// MARK: - ChooseAccounts
public struct ChooseAccounts: ReducerProtocol {
	public init() {}
}

public extension ChooseAccounts {
	var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			switch action {
			case .internal(.user(.finishedChoosingAccounts)):
				let nonEmptySelectedAccounts = NonEmpty(rawValue: OrderedSet(state.accounts.filter(\.isSelected).map(\.account)))!
				return .run { send in
					await send(.coordinate(.finishedChoosingAccounts(nonEmptySelectedAccounts)))
				}

			case .internal(.user(.dismissChooseAccounts)):
				return .run { send in
					await send(.coordinate(.dismissChooseAccounts))
				}

			case let .account(id: id, action: action):
				guard let account = state.accounts[id: id] else { return .none }
				switch action {
				case .internal(.user(.didSelect)):
					if account.isSelected {
						state.accounts[id: id]?.isSelected = false
					} else {
						switch state.incomingConnectionRequestFromDapp.numberOfNeededAccounts {
						case .atLeastOne:
							state.accounts[id: id]?.isSelected = true
						case let .exactly(number):
							guard state.selectedAccounts.count < number else { break }
							state.accounts[id: id]?.isSelected = true
						}
					}

					switch state.incomingConnectionRequestFromDapp.numberOfNeededAccounts {
					case .atLeastOne:
						state.canProceed = state.selectedAccounts.count >= 1
					case let .exactly(number):
						state.canProceed = state.selectedAccounts.count == number
					}

					return .none
				}
			case .coordinate:
				return .none
			}
		}
		.forEach(\.accounts, action: /Action.account(id:action:)) {
			ChooseAccounts.Row()
		}
	}
}