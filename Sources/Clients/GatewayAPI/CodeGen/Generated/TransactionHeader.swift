//
// TransactionHeader.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - TransactionHeader
public struct TransactionHeader: Codable, Hashable {
	public private(set) var version: Int
	public private(set) var networkId: Int
	/** An integer between 0 and 10^10, marking the epoch from which the transaction can be submitted */
	public private(set) var startEpochInclusive: Int64
	/** An integer between 0 and 10^10, marking the epoch from which the transaction will no longer be valid, and be rejected */
	public private(set) var endEpochExclusive: Int64
	/** A decimal-string-encoded integer between 0 and 2^64 - 1, chosen to be unique to allow replay of transaction intents */
	public private(set) var nonce: String
	public private(set) var notaryPublicKey: PublicKey
	/** Specifies whether the notary's signature should be included in transaction signers list */
	public private(set) var notaryAsSignatory: Bool
	/** An integer between 0 and 2^32 - 1, giving the maximum number of cost units available for transaction execution. */
	public private(set) var costUnitLimit: Int64
	/** An integer between 0 and 2^32 - 1, giving the validator tip as a percentage amount. A value of \"1\" corresponds to 1% of the fee. */
	public private(set) var tipPercentage: Int64

	public init(version: Int, networkId: Int, startEpochInclusive: Int64, endEpochExclusive: Int64, nonce: String, notaryPublicKey: PublicKey, notaryAsSignatory: Bool, costUnitLimit: Int64, tipPercentage: Int64) {
		self.version = version
		self.networkId = networkId
		self.startEpochInclusive = startEpochInclusive
		self.endEpochExclusive = endEpochExclusive
		self.nonce = nonce
		self.notaryPublicKey = notaryPublicKey
		self.notaryAsSignatory = notaryAsSignatory
		self.costUnitLimit = costUnitLimit
		self.tipPercentage = tipPercentage
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case version
		case networkId = "network_id"
		case startEpochInclusive = "start_epoch_inclusive"
		case endEpochExclusive = "end_epoch_exclusive"
		case nonce
		case notaryPublicKey = "notary_public_key"
		case notaryAsSignatory = "notary_as_signatory"
		case costUnitLimit = "cost_unit_limit"
		case tipPercentage = "tip_percentage"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(version, forKey: .version)
		try container.encode(networkId, forKey: .networkId)
		try container.encode(startEpochInclusive, forKey: .startEpochInclusive)
		try container.encode(endEpochExclusive, forKey: .endEpochExclusive)
		try container.encode(nonce, forKey: .nonce)
		try container.encode(notaryPublicKey, forKey: .notaryPublicKey)
		try container.encode(notaryAsSignatory, forKey: .notaryAsSignatory)
		try container.encode(costUnitLimit, forKey: .costUnitLimit)
		try container.encode(tipPercentage, forKey: .tipPercentage)
	}
}