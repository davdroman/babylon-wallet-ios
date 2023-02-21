import Foundation

// MARK: - FactorSourceKind
public enum FactorSourceKind: String, Sendable, Hashable, Codable {
	/// A user owned unencrypted mnemonic (and BIP39 passphrase) stored on device,
	/// thus directly usable. This kind is used as the standard factor source for all new
	/// wallet users.
	///
	/// Attributes:
	/// * Mine
	/// * On device
	/// * Hierarchical deterministic (Mnemonic)
	case device

	/// A user owned factor source which is encrypted by security questions and stored
	/// on device that supports hierarchical deterministic derivation when decrypted.
	///
	/// Attributes:
	/// * Mine
	/// * On device
	/// * Hierarchical deterministic (Mnemonic)
	/// * Encrypted by Security Questions
	case securityQuestions

	/// A user owned hardware wallet by vendor Ledger HQ, most commonly
	/// a Ledger Nano S or Ledger Nano X. Less common models are Ledger Nano S Plus
	/// Ledger Stax.
	///
	/// Attributes:
	/// * Mine
	/// * Off device
	/// * Hardware (requires Browser Connector Extension to communicate with wallet)
	/// * Hierarchical deterministic
	case ledgerHQHardwareWallet

	/// A user owned hardware wallet by vendor YubiCo, whic the uesr has to produce (connect)
	/// in order to use. Most common model might beYubiKey 5C NFC.
	///
	/// Attributes:
	/// * Mine
	/// * Off device
	/// * Hardware (directly readable by wallet)
	case yubiKey

	/// A user known single key which the user has to produce (input) in order to user.
	///
	/// Attributes:
	/// * Mine
	/// * Off device
	case offDeviceSingleKey

	/// A user known mnemonic which the user has to produce (input) in order to user.
	///
	/// Attributes:
	/// * Mine
	/// * Off device
	/// * Hierarchical deterministic
	case offDeviceMnemonic

	/// A user known secret acting as input key material (`IKM`) for some
	/// function which maps it to Entropy for a Mnemonic.
	///
	/// Attributes:
	/// * Mine
	/// * Off device
	/// * Hierarchical deterministic
	case offDeviceInputKeyMaterialForMnemonic

	/// Some individual the user knows and trust, e.g. a friend or family member,
	/// typically used as a factor source for the recovery role.
	///
	/// Attributes:
	/// * **Not** mine
	/// * Off device
	case trustedContact

	/// Some entity the user knows and trust, e.g. a company.
	/// typically used as a factor source for the recovery role.
	///
	/// Attributes:
	/// * **Not** mine
	/// * Off device
	case trustedEnterprise
}

extension FactorSourceKind {
	public var isHD: Bool {
		switch self {
		case .device, .ledgerHQHardwareWallet, .offDeviceMnemonic, .securityQuestions, .offDeviceInputKeyMaterialForMnemonic: return true
		case .offDeviceSingleKey, .yubiKey, .trustedContact, .trustedEnterprise: return false
		}
	}

	public var isOnDevice: Bool {
		switch self {
		case .device, .securityQuestions: return true
		case .offDeviceSingleKey, .offDeviceMnemonic, .offDeviceInputKeyMaterialForMnemonic, .ledgerHQHardwareWallet, .yubiKey, .trustedContact, .trustedEnterprise:
			return false
		}
	}

	public var isMine: Bool {
		switch self {
		case .trustedEnterprise, .trustedContact: return false
		case .device, .securityQuestions, .yubiKey, .ledgerHQHardwareWallet, .offDeviceMnemonic, .offDeviceSingleKey, .offDeviceInputKeyMaterialForMnemonic: return true
		}
	}

	public enum HardwareKind: String, Sendable, Equatable {
		case canCommunicatedDirectlyWithWallet
		case requiresBrowserConnectorExtensionForCommunication
	}

	public var hardwareKind: HardwareKind? {
		switch self {
		case .ledgerHQHardwareWallet: return .requiresBrowserConnectorExtensionForCommunication
		case .yubiKey: return .canCommunicatedDirectlyWithWallet
		case .device, .securityQuestions, .trustedContact, .trustedEnterprise, .offDeviceMnemonic, .offDeviceSingleKey, .offDeviceInputKeyMaterialForMnemonic: return nil
		}
	}
}