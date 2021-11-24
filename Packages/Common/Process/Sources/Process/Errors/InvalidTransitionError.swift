import Foundation

public struct InvalidTransitionError: Error {
  let source: State
  let command: Command
}
