import UIKit
import Weak
import Unexpected

public struct LoginFactory {
  public init() {

  }

  public func build() -> UIViewController {
//    let gateway = RemoteLoginNetworkGateway(url: "https://adopt.rzeszot.pro/api/auth/login-password", session: .shared)
    let gateway = LoginNetworkGatewayStub()
    let vc = LoginViewController()
    let interactor = LoginInteractor(output: Weak(vc), gateway: gateway)

    vc.interactor = interactor

    return vc
  }
}

extension Weak: LoginUseCaseOutput where T: LoginUseCaseOutput {
  func done(result: LoginResult) {
    object?.done(result: result)
  }

  func show(error: LoginError) {
    object?.show(error: error)
  }
}

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
