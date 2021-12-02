import Foundation
import Networking

struct RemoteLoginNetworkGateway: LoginNetworkGateway {
  let url: URL
  let session: URLSession

  private let parser: Parser = [
    LoginSuccessResponse.self,
    InvalidCredentialsResponse.self
  ]

  func build(_ request: LoginRequest) throws -> URLRequest {
    var r = URLRequest.post(url)
    try r.body(json: request)
    return r
  }

  func perform(_ request: LoginRequest) async throws -> LoginSuccessResponse {
    try await session.perform(request: build(request), using: parser)
  }

}
