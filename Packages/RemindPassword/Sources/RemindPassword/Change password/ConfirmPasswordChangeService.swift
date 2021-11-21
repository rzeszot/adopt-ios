import Foundation
import Networking
import Unexpected

struct ConfirmPasswordChangeService {
//
  // MARK: -

  let session: URLSession
  let parser: Parser = [
    SuccessResponse.self,
    FailureResponse.self
  ]

  // MARK: -

  struct Request: Encodable {
    let password: String
    let token: String
  }

  // MARK: -

  struct SuccessResponse: Response {
    static var code: Int = 202
  }

  struct FailureResponse: Response, Error {
    static var code: Int = 404
  }

  // MARK: -

  func request(password: String, token: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/sessions/set-password")
    try request.body(json: Request(password: password, token: token))
    return request
  }

  func perform(password: String, token: String) async throws -> SuccessResponse {
    try await session.perform(request: request(password: password, token: token), using: parser)
  }
}
