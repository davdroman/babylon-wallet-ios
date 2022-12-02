import Foundation

#if DEBUG
import Dependencies
import XCTestDynamicOverlay
extension NetworkSwitchingClient: TestDependencyKey {
	public static let testValue: Self = .init(
		getNetworkAndGateway: unimplemented("\(Self.self).getNetworkAndGateway"),
		validateGatewayURL: unimplemented("\(Self.self).validateGatewayURL"),
		hasAccountOnNetwork: unimplemented("\(Self.self).hasAccountOnNetwork"),
		switchTo: unimplemented("\(Self.self).switchTo")
	)
}
#endif