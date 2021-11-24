import Foundation
import Networking

struct RequestPasswordResetService {

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

  func build(username: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/account/forgot-password/request")
    try request.body(json: Request(username: username))
    return request
  }

  func request(username: String) async throws -> SuccessResponse {
    try await session.perform(request: build(username: username), using: parser)
  }

}
