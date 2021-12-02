import UIKit
import ConfirmPasswordChange

struct ChangePasswordBuilder {
  let cancel: () -> Void
  let next: () -> Void

  public init(cancel: @escaping () -> Void, next: @escaping () -> Void) {
    self.cancel = cancel
    self.next = next
  }

  func build() -> UIViewController {
    let vc = ChangePasswordViewController()
    vc.output = ChangePasswordOutput(
      close: {
        self.cancel()
      },
      submit: { password in
        self.next()
      }
    )

    return vc
  }
}

// MARK: - Routing

protocol ChangePasswordRouting: Routing {

}

extension ChangePasswordViewController: ChangePasswordRouting {

}
