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
    let grant = "password"

    let username: String
    let password: String

    enum CodingKeys: String, CodingKey {
      case grant = "grant_type"
      case username
      case password
    }
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

  func build(username: String, password: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/auth/token")
    try request.body(json: Request(username: username, password: password))
    return request
  }

  func request(username: String, password: String) async throws -> SuccessResponse {
    try await session.perform(request: build(username: username, password: password), using: parser)
  }

}
