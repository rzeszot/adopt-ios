import Foundation
import Networking
import Unexpected

struct Service {

  let session: URLSession
  let parser: Parser = [
    SuccessResponse.self,
    UpgradeRequiredResponse.self,
    ServiceUnavailableResponse.self,
    InvalidCredentialsResponse.self
  ]

  // MARK: -

  struct Request: Codable {
    let login: String
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

  func login(username: String, password: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/sessions")
    try request.body(json: Request(login: username, password: password))
    return request
  }

  func perform(username: String, password: String) async throws -> SuccessResponse {
    try await session.perform(request: login(username: username, password: password), using: parser)
  }

}
