import Foundation

public struct PasswordUpdatedOutput {
  public let close: () -> Void
  public let done: () -> Void

  public init(close: @escaping () -> Void, done: @escaping () ->  Void) {
    self.close = close
    self.done = done
  }
}
