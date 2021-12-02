import UIKit
import Guest

typealias GuestRouter = GuestViewController

struct GuestBuilder {
  func build() -> UIViewController {
    let vc = GuestViewController()
    vc.login()
    return vc
  }
}

// MARK: - Routing

protocol GuestRouting: Routing {
  func login()
  func register()
  func confirm()
}

extension GuestRouter: GuestRouting {
  func login() {
    show(vc: LoginBuilder().build())
  }

  func register() {
    show(vc: RegisterBuilder().build())
  }

  func confirm() {
    let builder = ConfirmPasswordChangeBuilder()
    let vc = builder.build()

    show(vc: vc)
    (vc as? ConfirmPasswordChangeRouting)?.resetPassword()
  }

  // MARK: -

  func dispatch(_ command: RoutingCommand) {
    if command is ConfirmPasswordResetRoutingCommand {
      confirm()
    }
  }

}

