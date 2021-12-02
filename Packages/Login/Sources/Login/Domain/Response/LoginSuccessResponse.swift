import Networking

struct LoginSuccessResponse: Response {
  static var code: Int = 201

  let token: String

  enum CodingKeys: String, CodingKey {
    case token = "access_token"
  }
}
