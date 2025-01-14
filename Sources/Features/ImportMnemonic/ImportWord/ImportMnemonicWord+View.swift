import Cryptography
import FeaturePrelude

// MARK: - Single word
extension ImportMnemonicWord.State {
	var viewState: ImportMnemonicWord.ViewState {
		.init(
			isReadonlyMode: isReadonlyMode,
			index: id,
			placeholder: placeholder,
			displayText: value.text,
			autocompletionCandidates: autocompletionCandidates,
			focusedField: focusedField,
			validation: {
				if value.hasFailedValidation {
					return .invalid
				} else if value.isComplete {
					return .valid
				} else {
					return nil
				}
			}()
		)
	}
}

// MARK: - Validation
enum Validation: Sendable, Hashable {
	case invalid
	case valid
}

extension ImportMnemonicWord {
	public struct ViewState: Equatable {
		let isReadonlyMode: Bool
		let index: Int
		let placeholder: String
		let displayText: String
		let autocompletionCandidates: ImportMnemonicWord.State.AutocompletionCandidates?
		let focusedField: State.Field?

		let validation: Validation?

		var hint: Hint? {
			guard let validation, validation == .invalid else {
				return nil
			}
			return .error(L10n.Common.invalid)
		}

		var showClearButton: Bool {
			focusedField != nil
		}

		var displayValidAccessory: Bool {
			!isReadonlyMode && validation == .valid && focusedField == nil
		}
	}

	@MainActor
	public struct View: SwiftUI.View {
		@FocusState private var focusedField: State.Field?
		private let store: StoreOf<ImportMnemonicWord>

		public init(store: StoreOf<ImportMnemonicWord>) {
			self.store = store
		}

		public var body: some SwiftUI.View {
			WithViewStore(store, observe: \.viewState, send: { .view($0) }) { viewStore in
				VStack(spacing: .small3) {
					AppTextField(
						primaryHeading: .init(text: L10n.ImportMnemonic.wordHeading(viewStore.index + 1), isProminent: true),
						placeholder: viewStore.placeholder,
						text: .init(
							get: { viewStore.displayText },
							set: { viewStore.send(.wordChanged(input: $0.lowercased().trimmingWhitespacesAndNewlines())) }
						),
						hint: viewStore.hint,
						focus: .on(
							.textField,
							binding: viewStore.binding(
								get: \.focusedField,
								send: { .textFieldFocused($0) }
							),
							to: $focusedField
						),
						showClearButton: viewStore.showClearButton,
						innerAccessory: {
							if viewStore.displayValidAccessory {
								Image(asset: AssetResource.successCheckmark)
									.resizable()
									.frame(.smallest)
							}
						}
					)
					.disabled(viewStore.isReadonlyMode)
					.minimumScaleFactor(0.9)
					.keyboardType(.alphabet)
					.textInputAutocapitalization(.never)
					.autocorrectionDisabled()
					.toolbar {
						// We only display the currently selected textfields candidates
						if let autocompletionCandidates = viewStore.autocompletionCandidates, viewStore.focusedField != nil {
							ToolbarItemGroup(placement: .keyboard) {
								ScrollView(.horizontal, showsIndicators: false) {
									HStack {
										ForEach(autocompletionCandidates.candidates, id: \.self) { candidate in
											Button(candidate.word.rawValue) {
												viewStore.send(.userSelectedCandidate(candidate))
											}
											.buttonStyle(.primaryRectangular(height: .toolbarButtonHeight))
										}
									}
								}
								.mask {
									Rectangle()
										.fill()
										.frame(height: .toolbarButtonHeight)
										.cornerRadius(.small2)
								}
							}
						}
					}

					if viewStore.hint == nil {
						Hint.error(L10n.Common.invalid) // Dummy spacer
							.opacity(0)
					}
				}
			}
		}
	}
}
