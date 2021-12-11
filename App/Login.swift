import UIKit
import Login

protocol LoginRoutable: UpstreamRouting {
  func user()
  func close()
}

// MARK: -

extension LoginViewController: LoginRoutable {
  func user() {

  }

  func close() {

  }

  private var root: RootRoutable? {
    upstream(of: RootRoutable.self)
  }
}

// MARK: -

struct LoginBuilder {
  func build() -> UIViewController {
    let factory = LoginFactory(input: LoginInput(gateway: .stub), output: LoginOutput(close: {
      print("login.close")
    }))
    let vc = factory.build()
    return vc
  }
}
