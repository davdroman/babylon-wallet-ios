import Prelude
import SwiftUI

// TODO: replace usage with AttributedStringBuilder
// (@davdroman will work on one and open source it in his spare time)
extension AttributedString {
	public init(_ string: some StringProtocol, foregroundColor: Color) {
		self = with(AttributedString(string)) { $0.foregroundColor = foregroundColor }
	}
}