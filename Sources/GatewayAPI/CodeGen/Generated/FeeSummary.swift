//
// FeeSummary.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - FeeSummary
/** Fees paid */
public struct FeeSummary: Codable, Hashable {
	/** Specifies whether the transaction execution loan has been fully repaid. */
	public private(set) var loanFullyRepaid: Bool
	/** An integer between 0 and 2^32 - 1, representing the maximum amount of cost units available for the transaction execution. */
	public private(set) var costUnitLimit: Int64
	/** An integer between 0 and 2^32 - 1, representing the amount of cost units consumed by the transaction execution. */
	public private(set) var costUnitConsumed: Int64
	/** A decimal-string-encoded integer between 0 and 2^255-1, which represents the total number of 10^(-18) subunits in the XRD price of a single cost unit.  */
	public private(set) var costUnitPriceAttos: String
	/** An integer between 0 and 2^32 - 1, specifying the validator tip as a percentage amount. A value of \"1\" corresponds to 1% of the fee. */
	public private(set) var tipPercentage: Int64
	/** A decimal-string-encoded integer between 0 and 2^255-1, which represents the total number of 10^(-18) subunits in the total amount of XRD burned in the transaction.  */
	public private(set) var xrdBurnedAttos: String
	/** A decimal-string-encoded integer between 0 and 2^255-1, which represents the total number of 10^(-18) subunits in the total amount of XRD tipped to validators in the transaction.  */
	public private(set) var xrdTippedAttos: String

	public init(loanFullyRepaid: Bool, costUnitLimit: Int64, costUnitConsumed: Int64, costUnitPriceAttos: String, tipPercentage: Int64, xrdBurnedAttos: String, xrdTippedAttos: String) {
		self.loanFullyRepaid = loanFullyRepaid
		self.costUnitLimit = costUnitLimit
		self.costUnitConsumed = costUnitConsumed
		self.costUnitPriceAttos = costUnitPriceAttos
		self.tipPercentage = tipPercentage
		self.xrdBurnedAttos = xrdBurnedAttos
		self.xrdTippedAttos = xrdTippedAttos
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case loanFullyRepaid = "loan_fully_repaid"
		case costUnitLimit = "cost_unit_limit"
		case costUnitConsumed = "cost_unit_consumed"
		case costUnitPriceAttos = "cost_unit_price_attos"
		case tipPercentage = "tip_percentage"
		case xrdBurnedAttos = "xrd_burned_attos"
		case xrdTippedAttos = "xrd_tipped_attos"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(loanFullyRepaid, forKey: .loanFullyRepaid)
		try container.encode(costUnitLimit, forKey: .costUnitLimit)
		try container.encode(costUnitConsumed, forKey: .costUnitConsumed)
		try container.encode(costUnitPriceAttos, forKey: .costUnitPriceAttos)
		try container.encode(tipPercentage, forKey: .tipPercentage)
		try container.encode(xrdBurnedAttos, forKey: .xrdBurnedAttos)
		try container.encode(xrdTippedAttos, forKey: .xrdTippedAttos)
	}
}