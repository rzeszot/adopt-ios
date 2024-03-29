import Foundation

public struct LoginRequest: Encodable {
  public let username: String
  public let password: String

  public init(username: String, password: String) {
    self.username = username
    self.password = password
  }
}
