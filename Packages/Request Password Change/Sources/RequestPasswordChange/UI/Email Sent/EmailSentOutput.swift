import Foundation

public struct EmailSentOutput {
  public let back: () -> Void
  public let done: () -> Void

  public init(back: @escaping () -> Void, done: @escaping () -> Void) {
    self.back = back
    self.done = done
  }
}
