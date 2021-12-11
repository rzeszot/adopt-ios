import Foundation

public struct LoginRequest: Encodable {
  public let username: String
  public let password: String
}
