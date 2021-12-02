import UIKit
import ConfirmPasswordChange

struct PasswordUpdatedBuilder {
  let close: () -> Void
  let done: () -> Void

  public init(close: @escaping () -> Void, done: @escaping () -> Void) {
    self.close = close
    self.done = done
  }

  func build() -> UIViewController {
    let vc = PasswordUpdatedViewController()
    vc.viewModel = PasswordUpdatedViewModel(username: nil)
    vc.output = PasswordUpdatedOutput(
      close: {
        self.close()
      },
      done: {
        self.done()
      }
    )

    return vc
  }
}

// MARK: - Routing

protocol PasswordUpdatedRouting: Routing {

}

extension PasswordUpdatedViewController: PasswordUpdatedRouting {

}
