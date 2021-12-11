import Foundation
import Unexpected

struct LoginNetworkGatewayStub: LoginNetworkGateway {
  func perform(_ request: LoginRequest) async throws -> LoginSuccessResponse {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<LoginSuccessResponse, Error>) in
      DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(2)) {
        if Bool.random() {
          continuation.resume(returning: LoginSuccessResponse(token: "TOKEN"))
        } else if Bool.random() {
          continuation.resume(throwing: InvalidCredentialsResponse())
        } else {
          continuation.resume(throwing: UnexpectedError())
        }
      }
    }
  }
}
