import Foundation
import Networking
import Unexpected

struct AuthorizeService {

  let session: URLSession
  let parser: Parser = [
    SuccessResponse.self,
    InvalidClientResponse.self,
    UpgradeRequiredResponse.self
  ]

  // MARK: -

  struct Request: Encodable {
    let grant_type = "password"

    let username: String
    let password: String
  }

  // MARK: -

  struct SuccessResponse: Response {
    static var code = 201

    let token: String

    enum CodingKeys: String, CodingKey {
      case token = "access_token"
    }
  }

  // MARK: -

  struct InvalidClientResponse: Response, Error {
    static let code = 401

    let error: String // invalid_client
    let description: String?

    enum CodingKeys: String, CodingKey {
      case error
      case description = "error_description"
    }
  }

  // MARK: -

  func login(username: String, password: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/auth/token")
    try request.body(json: Request(username: username, password: password))
    return request
  }

  func perform(username: String, password: String) async throws -> SuccessResponse {
    try await session.perform(request: login(username: username, password: password), using: parser)
  }

}
