import Foundation

public struct EnterUsernameOutput {
  public let close: () -> Void
  public let submit: (String) -> Void

  public init(close: @escaping () -> Void, submit: @escaping (String) -> Void) {
    self.close = close
    self.submit = submit
  }
}
