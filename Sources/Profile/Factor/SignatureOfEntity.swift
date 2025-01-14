import Cryptography
import Foundation

// MARK: - SignatureOfEntity
public struct SignatureOfEntity: Sendable, Hashable {
	public let signerEntity: EntityPotentiallyVirtual
	public let derivationPath: DerivationPath
	public let factorSourceID: FactorSourceID
	public let signatureWithPublicKey: Cryptography.SignatureWithPublicKey

	public init(
		signerEntity: EntityPotentiallyVirtual,
		derivationPath: DerivationPath,
		factorSourceID: FactorSourceID,
		signatureWithPublicKey: Cryptography.SignatureWithPublicKey
	) {
		self.signerEntity = signerEntity
		self.derivationPath = derivationPath
		self.factorSourceID = factorSourceID
		self.signatureWithPublicKey = signatureWithPublicKey
	}
}
