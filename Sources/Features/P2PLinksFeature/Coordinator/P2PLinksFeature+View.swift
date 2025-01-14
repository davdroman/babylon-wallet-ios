import FeaturePrelude
import NewConnectionFeature
import RadixConnectClient

// MARK: - P2PLinks.View
extension P2PLinksFeature {
	public struct ViewState: Equatable {
		public let linkRows: IdentifiedArrayOf<P2PLinkRow.State>

		init(state: P2PLinksFeature.State) {
			linkRows = state.links
		}
	}

	@MainActor
	public struct View: SwiftUI.View {
		private let store: StoreOf<P2PLinksFeature>

		public init(store: StoreOf<P2PLinksFeature>) {
			self.store = store
		}

		public var body: some SwiftUI.View {
			WithViewStore(
				store,
				observe: ViewState.init(state:),
				send: { .view($0) }
			) { viewStore in
				ScrollView {
					Text(L10n.LinkedConnectors.subtitle)
						.foregroundColor(.app.gray2)
						.textStyle(.body1HighImportance)
						.flushedLeft
						.padding([.horizontal, .top], .medium3)
						.padding(.bottom, .small2)

					Separator()

					VStack(alignment: .leading) {
						ForEachStore(
							store.scope(
								state: \.links,
								action: { .child(.connection(id: $0, action: $1)) }
							),
							content: {
								P2PLinkRow.View(store: $0)
									.padding(.medium3)

								Separator()
							}
						)
					}
					Button(L10n.LinkedConnectors.linkNewConnector) {
						viewStore.send(.addNewConnectionButtonTapped)
					}
					.buttonStyle(.secondaryRectangular(
						shouldExpand: true,
						image: .init(asset: AssetResource.qrCodeScanner)
					))
					.padding(.horizontal, .medium3)
					.padding(.vertical, .large1)
				}
				.navigationTitle(L10n.LinkedConnectors.title)
				.task { @MainActor in
					await store.send(.view(.task)).finish()
				}
				.sheet(
					store: store.scope(state: \.$destination, action: { .child(.destination($0)) }),
					state: /P2PLinksFeature.Destinations.State.newConnection,
					action: P2PLinksFeature.Destinations.Action.newConnection,
					content: { NewConnection.View(store: $0) }
				)
				.alert(
					store: store.scope(state: \.$destination, action: { .child(.destination($0)) }),
					state: /P2PLinksFeature.Destinations.State.removeConnection,
					action: P2PLinksFeature.Destinations.Action.removeConnection
				)
			}
		}
	}
}

#if DEBUG
import SwiftUI // NB: necessary for previews to appear

struct P2PLinksFeature_Preview: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			P2PLinksFeature.View(
				store: .init(
					initialState: .previewValue,
					reducer: P2PLinksFeature.init
				)
			)
			#if os(iOS)
			.navigationBarTitleDisplayMode(.inline)
			#endif
		}
	}
}

extension P2PLinksFeature.State {
	public static let previewValue: Self = .init()
}
#endif
