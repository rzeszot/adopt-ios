import Foundation

public struct RequestInput {
  public enum CloseReason {
    case cancel
    case request
  }

  let username: String?
  let close: (CloseReason) -> Void

  public init(username: String?, close: @escaping (CloseReason) -> Void) {
    self.username = username
    self.close = close
  }
}
