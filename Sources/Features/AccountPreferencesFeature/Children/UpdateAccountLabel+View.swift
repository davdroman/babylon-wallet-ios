import FeaturePrelude

extension UpdateAccountLabel.State {
	var viewState: UpdateAccountLabel.ViewState {
		let (controlState, hint) = hintAndControlState
		return .init(
			accountLabel: accountLabel,
			sanitizedName: sanitizedName,
			updateButtonControlState: controlState,
			hint: hint
		)
	}

	private var hintAndControlState: (ControlState, Hint?) {
		if let sanitizedName {
			if sanitizedName.count > Profile.Network.Account.nameMaxLength {
				return (.disabled, .error("Account label too long")) // FIXME: Strings (duplicate)
			}
		} else {
			return (.disabled, .error("Account label required")) // FIXME: Strings (duplicate)
		}

		return (.enabled, nil)
	}
}

extension UpdateAccountLabel {
	public struct ViewState: Equatable {
		let accountLabel: String
		let sanitizedName: NonEmptyString?
		let updateButtonControlState: ControlState
		let hint: Hint?
	}

	@MainActor
	public struct View: SwiftUI.View {
		let store: StoreOf<UpdateAccountLabel>

		init(store: StoreOf<UpdateAccountLabel>) {
			self.store = store
		}

		public var body: some SwiftUI.View {
			WithViewStore(store, observe: \.viewState, send: { .view($0) }) { viewStore in
				VStack {
					VStack(alignment: .center, spacing: .medium1) {
						let nameBinding = viewStore.binding(
							get: \.accountLabel,
							send: { .accountLabelChanged($0) }
						)
						AppTextField(
							primaryHeading: .init(text: L10n.AccountSettings.RenameAccount.subtitle),
							placeholder: "",
							text: nameBinding,
							hint: viewStore.hint
						)
						.keyboardType(.asciiCapable)
						.autocorrectionDisabled()

						WithControlRequirements(
							viewStore.sanitizedName,
							forAction: { viewStore.send(.updateTapped($0)) }
						) { action in
							Button(L10n.AccountSettings.SpecificAssetsDeposits.update) {
								action()
							}
							.buttonStyle(.primaryRectangular)
							.controlState(viewStore.updateButtonControlState)
						}
					}
					.padding(.large3)
					.background(.app.background)

					Spacer(minLength: 0)
				}
				.background(.app.gray5)
				.navigationTitle(L10n.AccountSettings.RenameAccount.title)
				.defaultNavBarConfig()
			}
		}
	}
}

extension View {
	func defaultNavBarConfig() -> some View {
		navigationBarTitleColor(.app.gray1)
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarInlineTitleFont(.app.secondaryHeader)
			.toolbarBackground(.app.background, for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
	}
}
