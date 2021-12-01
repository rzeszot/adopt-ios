import Foundation

public struct InvalidTransitionError: Error {
  public let state: State
  public let command: Command

  public init(state: State, command: Command) {
    self.state = state
    self.command = command
  }
}
