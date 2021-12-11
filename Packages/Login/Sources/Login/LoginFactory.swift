import UIKit
import Weak
import Unexpected

public struct LoginFactory {
  private let input: LoginInput
  private let output: LoginOutput

  public init(input: LoginInput, output: LoginOutput) {
    self.input = input
    self.output = output
  }

  public func build() -> UIViewController {
    let vc = LoginViewController()

    vc.aaa = LoginInteractor(output: Weak(vc), gateway: gateway)
    vc.bbb = TransitionInteractor(output: output)

    return vc
  }

  private var gateway: LoginNetworkGateway {
    switch input.gateway {
    case .production(let url):
      return RemoteLoginNetworkGateway(url: url, session: .shared)
    case .stub:
      return LoginNetworkGatewayStub()
    case .custom(let implementation):
      return implementation
    }
  }

}

extension Weak: LoginUseCaseOutput where T: LoginUseCaseOutput {
  public func done(result: LoginSuccess) {
    object?.done(result: result)
  }

  public func show(error: LoginFailure) {
    object?.show(error: error)
  }
}
