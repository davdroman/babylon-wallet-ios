//
// ParsedNotarizedTransactionAllOf.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

// MARK: - ParsedNotarizedTransactionAllOf
public struct ParsedNotarizedTransactionAllOf: Codable, Hashable {
	public private(set) var notarizedTransaction: NotarizedTransaction
	/** Gives if the transaction is statically valid. Note that, even if statically valid, the transaction may still be rejected or fail due to issues at runtime (eg if the loan cannot be repaid).  */
	public private(set) var isStaticallyValid: Bool
	/** If the transaction is not statically valid, this gives a reason.  */
	public private(set) var validityError: String?

	public init(notarizedTransaction: NotarizedTransaction, isStaticallyValid: Bool, validityError: String? = nil) {
		self.notarizedTransaction = notarizedTransaction
		self.isStaticallyValid = isStaticallyValid
		self.validityError = validityError
	}

	public enum CodingKeys: String, CodingKey, CaseIterable {
		case notarizedTransaction = "notarized_transaction"
		case isStaticallyValid = "is_statically_valid"
		case validityError = "validity_error"
	}

	// Encodable protocol methods

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(notarizedTransaction, forKey: .notarizedTransaction)
		try container.encode(isStaticallyValid, forKey: .isStaticallyValid)
		try container.encodeIfPresent(validityError, forKey: .validityError)
	}
}
