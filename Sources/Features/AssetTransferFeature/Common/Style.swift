import FeaturePrelude
import SwiftUI

extension View {
	func roundedCorners(_ corners: UIRectCorner = .allCorners, strokeColor: Color) -> some View {
		self
			.clipShape(RoundedCorners(corners: corners, radius: .small2))
			.background(
				RoundedCorners(corners: corners, radius: .small2)
					.stroke(strokeColor, lineWidth: 1)
			)
	}
}

extension Color {
	static let borderColor: Color = .app.gray4
	static let focusedBorderColor: Color = .app.gray1

	static let containerContentBackground: Color = .app.gray5
}

extension CGFloat {
	static let dottedLineHeight: CGFloat = 64.0
	public static let transferMessageDefaultHeight: Self = 64
}
