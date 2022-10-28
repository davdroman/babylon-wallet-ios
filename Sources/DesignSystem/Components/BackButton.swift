import SwiftUI

// MARK: - BackButton
public struct BackButton: View {
	let action: () -> Void

	public init(action: @escaping () -> Void) {
		self.action = action
	}
}

public extension BackButton {
	var body: some View {
		Button(
			action: action,
			label: { Image("arrow-back") }
		)
	}
}

// MARK: - BackButton_Previews
struct BackButton_Previews: PreviewProvider {
	static var previews: some View {
		BackButton {}
	}
}