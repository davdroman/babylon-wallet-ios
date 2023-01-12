import FeaturePrelude

// MARK: - ImportMnemonic.View
public extension ImportMnemonic {
	@MainActor
	struct View: SwiftUI.View {
		let store: StoreOf<ImportMnemonic>
		public init(store: StoreOf<ImportMnemonic>) {
			self.store = store
		}
	}
}

public extension ImportMnemonic.View {
	var body: some View {
		WithViewStore(
			store,
			observe: ViewState.init(state:),
			send: { .view($0) }
		) { viewStore in
			VStack {
				HStack {
					Button(
						action: {
							viewStore.send(.goBackButtonTapped)
						}, label: {
							Image(asset: AssetResource.arrowBack)
						}
					)
					Spacer()
					Text(L10n.ImportProfile.importMnemonic.capitalized)
					Spacer()
					EmptyView()
				}
				Spacer()

				TextField(
					L10n.ImportProfile.mnemonicPhrase,
					text: viewStore.binding(
						get: \.phraseOfMnemonicToImport,
						send: { .phraseOfMnemonicToImportChanged($0) }
					)
				)
				Button(
					L10n.ImportProfile.importMnemonic
				) {
					viewStore.send(.importMnemonicButtonTapped)
				}
				.controlState(viewStore.importMnemonicButtonState)

				Button(
					L10n.ImportProfile.saveImportedMnemonic
				) {
					viewStore.send(.saveImportedMnemonicButtonTapped)
				}
				.controlState(viewStore.saveImportedMnemonicButtonState)

				Button(
					L10n.ImportProfile.profileFromSnapshot
				) {
					viewStore.send(.importProfileFromSnapshotButtonTapped)
				}
				.controlState(viewStore.importProfileFromSnapshotButtonState)
			}
		}
		.buttonStyle(.primaryRectangular)
	}
}

// MARK: - ImportMnemonic.View.ViewState
public extension ImportMnemonic.View {
	struct ViewState: Equatable {
		public let phraseOfMnemonicToImport: String
		public let importMnemonicButtonState: ControlState
		public let saveImportedMnemonicButtonState: ControlState
		public let importProfileFromSnapshotButtonState: ControlState

		public init(state: ImportMnemonic.State) {
			phraseOfMnemonicToImport = state.phraseOfMnemonicToImport
			importMnemonicButtonState = !state.phraseOfMnemonicToImport.isEmpty ? .enabled : .disabled
			saveImportedMnemonicButtonState = state.importedMnemonic != nil ? .enabled : .disabled
			importProfileFromSnapshotButtonState = state.savedMnemonic != nil ? .enabled : .disabled
		}
	}
}
