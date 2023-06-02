import FeaturePrelude

// MARK: - NonFungibleAssetList.View
extension NonFungibleAssetList {
	@MainActor
	public struct View: SwiftUI.View {
		private let store: StoreOf<NonFungibleAssetList>

		public init(store: StoreOf<NonFungibleAssetList>) {
			self.store = store
		}

		public var body: some SwiftUI.View {
			VStack(spacing: .medium1) {
				ForEachStore(
					store.scope(
						state: \.rows,
						action: { .child(.asset($0, $1)) }
					),
					content: { NonFungibleAssetList.Row.View(store: $0) }
				)
			}
			.sheet(
				store: store.scope(state: \.$destination, action: { .child(.destination($0)) }),
				state: /NonFungibleAssetList.Destinations.State.details,
				action: NonFungibleAssetList.Destinations.Action.details,
				content: { detailsStore in
					NavigationStack {
						NonFungibleAssetList.Detail.View(store: detailsStore)
						#if os(iOS)
							.navigationBarTitleDisplayMode(.inline)
						#endif
							.toolbar {
								ToolbarItem(placement: .primaryAction) {
									CloseButton {
										ViewStore(store).send(.view(.closeDetailsTapped))
									}
								}
							}
					}
				}
			)
		}
	}
}

#if DEBUG
import SwiftUI // NB: necessary for previews to appear

struct NonFungibleTokenList_Preview: PreviewProvider {
	static var previews: some View {
		NonFungibleAssetList.View(
			store: .init(
				initialState: .init(rows: []),
				reducer: NonFungibleAssetList()
			)
		)
	}
}
#endif