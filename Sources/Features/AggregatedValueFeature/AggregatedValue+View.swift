import FeaturePrelude
import Profile

// MARK: - AggregatedValue.View
public extension AggregatedValue {
	@MainActor
	struct View: SwiftUI.View {
		public typealias Store = ComposableArchitecture.Store<State, Action>
		private let store: Store

		public init(
			store: Store
		) {
			self.store = store
		}
	}
}

public extension AggregatedValue.View {
	var body: some View {
		WithViewStore(
			store,
			observe: ViewState.init(state:),
			send: { .view($0) }
		) { viewStore in
			AggregatedValueView(
				value: viewStore.value,
				currency: viewStore.currency,
				isValueVisible: viewStore.isValueVisible,
				toggleVisibilityAction: {
					viewStore.send(.toggleVisibilityButtonTapped)
				}
			)
		}
	}
}

// MARK: - AggregatedValue.View.ViewState
extension AggregatedValue.View {
	// MARK: ViewState
	struct ViewState: Equatable {
		var isValueVisible: Bool
		var value: Float?
		var currency: FiatCurrency // FIXME: this should be currency, since it can be any currency

		init(state: AggregatedValue.State) {
			isValueVisible = state.isCurrencyAmountVisible
			value = state.value
			currency = state.currency
		}
	}
}

// MARK: - AggregatedValueView
private struct AggregatedValueView: View {
	let value: Float?
	let currency: FiatCurrency
	let isValueVisible: Bool
	let toggleVisibilityAction: () -> Void

	// TODO: is this the right way to handle no value -> 0?
	var amount: Float {
		value ?? 0
	}

	var formattedAmount: String {
		amount.formatted(.currency(code: currency.symbol))
	}

	var body: some View {
		HStack {
			Spacer()
			AmountView(
				isValueVisible: isValueVisible,
				amount: amount,
				formattedAmount: formattedAmount,
				fiatCurrency: currency
			)
			Spacer()
				.frame(width: 44)
			VisibilityButton(
				isVisible: isValueVisible,
				action: toggleVisibilityAction
			)
			Spacer()
		}
		.frame(height: 60)
	}
}

// MARK: - AmountView
// TODO: extract to separate Feature when view complexity increases
private struct AmountView: View {
	var isValueVisible: Bool
	let amount: Float // NOTE: used for copying the actual value
	let formattedAmount: String
	let fiatCurrency: FiatCurrency

	var body: some View {
		if isValueVisible {
			Text(formattedAmount)
				.foregroundColor(.app.buttonTextBlack)
				.textStyle(.sectionHeader)
		} else {
			HStack {
				Text("\(fiatCurrency.sign)")
					.foregroundColor(.app.buttonTextBlack)
					.textStyle(.sectionHeader)

				Text("••••••")
					.foregroundColor(.app.gray4)
					.textStyle(.sheetTitle)
					.offset(y: -3)
			}
		}
	}
}

// MARK: - VisibilityButton
private struct VisibilityButton: View {
	let isVisible: Bool
	let action: () -> Void

	var body: some View {
		Button(action: action) {
			if isVisible {
				Image(asset: AssetResource.homeAggregatedValueShown)
			} else {
				Image(asset: AssetResource.homeAggregatedValueHidden)
			}
		}
	}
}

#if DEBUG
struct AggregatedValue_Preview: PreviewProvider {
	static var previews: some View {
		AggregatedValue.View(
			store: .init(
				initialState: .previewValue,
				reducer: AggregatedValue()
			)
		)
	}
}
#endif
