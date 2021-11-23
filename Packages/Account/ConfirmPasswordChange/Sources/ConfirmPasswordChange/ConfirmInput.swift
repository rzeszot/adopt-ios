import Foundation

public struct ConfirmInput {
  public enum CloseReason {
    case cancel
    case dismiss
    case authorize
  }

  let username: String
  let code: String
  let close: (CloseReason) -> Void

  public init(username: String, code: String, close: @escaping (CloseReason) -> Void) {
    self.username = username
    self.code = code
    self.close = close
  }
}
