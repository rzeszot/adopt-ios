import Foundation

public struct Reset {
  public let username: String?

  public init(username: String?) {
    self.username = username
  }
}

public struct Confirm {
  public let username: String
  public let code: String

  public init(username: String, code: String) {
    self.username = username
    self.code = code
  }
}
