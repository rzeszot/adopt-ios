import Foundation

public struct Reset {
  public let username: String?

  public init(username: String?) {
    self.username = username
  }
}

public struct Confirm {
  public let token: String

  public init(token: String) {
    self.token = token
  }
}
