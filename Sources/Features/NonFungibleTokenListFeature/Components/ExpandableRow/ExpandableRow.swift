import FeaturePrelude

protocol ExpandableRow {
	var edge: Edge.Set { get }
	var value: CGFloat { get }
	var oppositeValue: CGFloat { get }
}
