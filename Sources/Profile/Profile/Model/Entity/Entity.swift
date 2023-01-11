import Cryptography
import EngineToolkit
import Prelude

// MARK: - EntityProtocol
/// An `Account` or a `Persona`
public protocol EntityProtocol {
	/// The type of address of entity.
	associatedtype EntityAddress: AddressKindProtocol

	/// The type of derivation path, differs between `Persona` and `Account`.
	associatedtype EntityDerivationPath: EntityDerivationPathProtocol

	static var entityKind: EntityKind { get }

	/// Index of the entity in some collection if entities of the same type.
	var index: Int { get }

	/// Derivation path used to derive public keys for factor instances protecting this entity.
	var derivationPath: EntityDerivationPath { get }

	/// The globally unique and identifiable Radix component address of this entity. Can be used as
	/// a stable ID. Cryptographically derived from a seeding public key which typically was created by
	/// the `DeviceFactorSource`
	var address: EntityAddress { get }

	/// Security state of this entity, either `secured` or not (controlled by a DeviceFactorInstance)
	var securityState: EntitySecurityState { get set }

	/// An optional displayName or label, used by presentation layer only.
	var displayName: String? { get }
}

public extension EntityProtocol {
	static func deriveAddress(
		networkID: NetworkID,
		publicKey: SLIP10.PublicKey
	) throws -> EntityAddress {
		let response = try EngineToolkit().deriveVirtualAccountAddressRequest(
			request: .init(
				publicKey: publicKey.intoEngine(),
				networkId: networkID
			)
		).get()

		return try EntityAddress(address: response.virtualAccountAddress.address)
	}
}