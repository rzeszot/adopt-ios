import UIKit
import Login

struct LoginBuilder {
  func build() -> UIViewController {
    LoginFactory().build()

//    let vc = LoginViewController()
//    vc.output = LoginOutput(remind: vc.remind, close: {}, login: vc.user)
//    return vc
  }
}

// MARK: - Routing

protocol LoginRouting: Routing {
  func user()
  func register()
  func remind(username: String?)
}

extension LoginViewController: LoginRouting {
  func user() {
    parent(of: RootRouting.self)?.user()
  }

  func register() {
    parent(of: GuestRouting.self)?.register()
  }

  func remind(username: String?) {
    let builder = RequestPasswordChangeBuilder(username: username) { [weak self] in
      self?.dismiss(animated: true)
    }
    let vc = builder.build()
    (vc as? RequestPasswordChangeRouting)?.enterUsername()

    present(vc, animated: true)
  }
}
