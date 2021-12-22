import Foundation

public struct RequestPasswordChangeOutput {
  public let dismiss: () -> Void

  public init(dismiss: @escaping () -> Void) {
    self.dismiss = dismiss
  }
}
