import Foundation
import Networking

struct RemoteClient {

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

  func build(username: String, password: String, code: String) throws -> URLRequest {
    var request = URLRequest.post("https://adopt.rzeszot.pro/account/forgot-password/confirm")
    try request.body(json: Request(username: username, password: password, code: code))
    return request
  }

  func request(username: String, password: String, code: String) async throws -> SuccessResponse {
    try await session.perform(request: build(username: username, password: password, code: code), using: parser)
  }

}

extension RemoteClient: Client {
  func request(username: String, password: String, code: String) async throws {
    let _: SuccessResponse = try await request(username: username, password: password, code: code)
  }
}
