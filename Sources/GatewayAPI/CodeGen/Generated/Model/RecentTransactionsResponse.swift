//
// RecentTransactionsResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct RecentTransactionsResponse: Sendable, Codable, Hashable {

    public var ledgerState: LedgerState
    /** The cursor to be provided for the next page of results. If missing, this is the last page of results. */
    public var nextCursor: String?
    /** The page of user transactions. */
    public var transactions: [TransactionInfo]

    public init(ledgerState: LedgerState, nextCursor: String? = nil, transactions: [TransactionInfo]) {
        self.ledgerState = ledgerState
        self.nextCursor = nextCursor
        self.transactions = transactions
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case ledgerState = "ledger_state"
        case nextCursor = "next_cursor"
        case transactions
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ledgerState, forKey: .ledgerState)
        try container.encodeIfPresent(nextCursor, forKey: .nextCursor)
        try container.encode(transactions, forKey: .transactions)
    }
}

