import Foundation

public struct ConfirmPasswordChangeOutput {
  public let done: () -> Void

  public init(done: @escaping () -> Void) {
    self.done = done
  }
}
