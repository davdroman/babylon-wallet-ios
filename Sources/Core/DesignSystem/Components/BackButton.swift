import Resources
import SwiftUI

// MARK: - BackButton
public struct BackButton: SwiftUI.View {
	let action: () -> Void

	public init(action: @escaping () -> Void) {
		self.action = action
	}
}

extension BackButton {
	public var body: some SwiftUI.View {
		Button(action: action) {
			Image(asset: AssetResource.arrowBack).tint(.app.gray1)
		}
		.frame(.small)
	}
}

// MARK: - BackButton_Previews
struct BackButton_Previews: PreviewProvider {
	static var previews: some View {
		BackButton {}
			.previewLayout(.sizeThatFits)
	}
}
