import Foundation

public struct Input {
  public enum CloseReason {
    case cancel
    case done
  }

  let username: String?
  let close: (CloseReason) -> Void

  public init(username: String?, close: @escaping (CloseReason) -> Void) {
    self.username = username
    self.close = close
  }
}
