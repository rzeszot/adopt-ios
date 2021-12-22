import Networking

public struct LoginSuccessResponse: Response {
  public static var code: Int = 201

  public let token: String

  enum CodingKeys: String, CodingKey {
    case token = "access_token"
  }
}
