import AsyncAlgorithms
import AsyncExtensions
import Foundation

public struct ErrorQueue {
	public var errors: @Sendable () -> AnyAsyncSequence<Error>
	public var schedule: @Sendable (Error) -> Void
}