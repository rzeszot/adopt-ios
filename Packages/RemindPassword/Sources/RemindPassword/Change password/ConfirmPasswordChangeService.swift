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
    let username: String
    let password: String
    let code: String
  }

  // MARK: -

  struct SuccessResponse: Response {
    static var code: Int = 202
  }

  struct FailureResponse: Response, Error {
    static var code: Int = 404
  }

  // MARK: -

  func request(username: String, password: String, code: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/account/forgot-password/confirm")
    try request.body(json: Request(username: username, password: password, code: code))
    return request
  }

  func perform(username: String, password: String, code: String) async throws -> SuccessResponse {
    try await session.perform(request: request(username: username, password: password, code: code), using: parser)
  }
}
