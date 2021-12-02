import UIKit
import RequestPasswordChange

struct EnterUsernameBuilder {
  let username: String?
  let dismiss: () -> Void

  public init(username: String?, dismiss: @escaping () -> Void) {
    self.username = username
    self.dismiss = dismiss
  }

  func build() -> UIViewController {
    let vc = EnterUsernameViewController()
    vc.viewModel = EnterUsernameViewModel(username: username)
    vc.output = EnterUsernameOutput(
      close: dismiss,
      submit: { [weak vc] username in
        vc?.done()
      })

    return vc
  }
}

// MARK: - Routing

protocol EnterUsernameRouting: Routing {
  func notFound()
  func done()
}

extension EnterUsernameViewController: EnterUsernameRouting {
  func notFound() {
    print("enter username | goto not found")
  }

  func done() {
    parent(of: RequestPasswordChangeRouting.self)?.emailSent()
  }
}
