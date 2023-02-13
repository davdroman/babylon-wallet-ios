import FeaturePrelude

// MARK: - PersonaList.View
extension PersonaList {
	@MainActor
	public struct View: SwiftUI.View {
		private let store: StoreOf<PersonaList>

		public init(store: StoreOf<PersonaList>) {
			self.store = store
		}
	}
}

extension PersonaList.View {
	public var body: some View {
		WithViewStore(
			store,
			observe: ViewState.init(state:),
			send: { .view($0) }
		) { viewStore in
			ForceFullScreen {
				VStack(spacing: .zero) {
					NavigationBar(
						titleText: L10n.PersonaList.title,
						leadingItem: BackButton {
							viewStore.send(.dismissButtonTapped)
						}
					)
					.foregroundColor(.app.gray1)
					.padding([.horizontal, .top], .medium3)

					Separator()

					ScrollView {
						HStack {
							Text(L10n.PersonaList.subtitle)
								.foregroundColor(.app.gray2)
								.textStyle(.body1HighImportance)
								.padding([.horizontal, .top], .medium3)
								.padding(.bottom, .small2)

							Spacer()
						}

						Separator()

						VStack(alignment: .leading) {
							ForEachStore(
								store.scope(
									state: \.personas,
									action: { .child(.persona(id: $0, action: $1)) }
								),
								content: {
									Persona.View(store: $0)
										.padding(.vertical, .small3)
								}
							)
						}.padding(.horizontal, .small1)
					}
				}
			}
		}
	}
}

// MARK: - PersonaList.View.ViewState
extension PersonaList.View {
	struct ViewState: Equatable {
		init(state: PersonaList.State) {
			// TODO: implement
		}
	}
}

#if DEBUG
import SwiftUI // NB: necessary for previews to appear

// MARK: - Personas_Preview
struct Personas_Preview: PreviewProvider {
	static var previews: some View {
		PersonaList.View(
			store: .init(
				initialState: .previewValue,
				reducer: PersonaList()
			)
		)
	}
}
#endif