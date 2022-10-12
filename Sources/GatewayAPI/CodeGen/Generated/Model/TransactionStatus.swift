//
// TransactionStatus.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct TransactionStatus: Sendable, Codable, Hashable {

    public enum Status: String, Sendable, Codable, CaseIterable {
        case succeeded = "succeeded"
        case failed = "failed"
        case rejected = "rejected"
        case pending = "pending"
    }
    public var stateVersion: Int64?
    public var status: Status
    public var confirmedTime: Date?

    public init(stateVersion: Int64? = nil, status: Status, confirmedTime: Date? = nil) {
        self.stateVersion = stateVersion
        self.status = status
        self.confirmedTime = confirmedTime
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case stateVersion = "state_version"
        case status
        case confirmedTime = "confirmed_time"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(stateVersion, forKey: .stateVersion)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(confirmedTime, forKey: .confirmedTime)
    }
}

