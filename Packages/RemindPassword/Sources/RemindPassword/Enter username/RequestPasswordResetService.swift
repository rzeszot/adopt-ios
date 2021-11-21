import Foundation
import Networking
import Unexpected

struct RequestPasswordResetService {

  // MARK: -

  let session: URLSession
  let parser: Parser = [
    SuccessResponse.self,
    FailureResponse.self
  ]

  // MARK: -

  struct Request: Encodable {
    let username: String
  }

  // MARK: -

  struct SuccessResponse: Response {
    static var code: Int = 202
  }

  struct FailureResponse: Response, Error {
    static var code: Int = 404
  }

  // MARK: -

  func request(username: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/sessions/reset-password")
    try request.body(json: Request(username: username))
    return request
  }

  func perform(username: String) async throws -> SuccessResponse {
    try await session.perform(request: request(username: "username"), using: parser)
  }
}
