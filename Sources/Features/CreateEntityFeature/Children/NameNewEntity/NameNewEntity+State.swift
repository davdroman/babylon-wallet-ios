import FeaturePrelude

// MARK: - NameNewEntity.State
extension NameNewEntity {
	public struct State: Sendable, Hashable {
		public var isFirst: Bool
		public var inputtedName: String
		public var sanitizedName: NonEmpty<String>?

		@BindingState public var focusedField: Field?

		public init(
			isFirst: Bool,
			inputtedEntityName: String = "",
			focusedField: Field? = nil
		) {
			self.inputtedName = inputtedEntityName
			self.focusedField = focusedField
			self.isFirst = isFirst
		}
	}
}

extension NameNewEntity.State {
	public init(config: CreateEntityConfig) {
		self.init(isFirst: config.isFirstEntity)
	}
}

// MARK: - NameNewEntity.State.Field
extension NameNewEntity.State {
	public enum Field: String, Sendable, Hashable {
		case entityName
	}
}