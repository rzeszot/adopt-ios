import UIKit
import Register

typealias RegisterRouter = RegisterViewController

struct RegisterBuilder {
  func build() -> UIViewController {
    let vc = RegisterViewController()
    return vc
  }
}

// MARK: - Routing

protocol RegisterRouting: Routing {
  func login()
}

extension RegisterRouter: RegisterRouting {
  func login() {

  }
}
