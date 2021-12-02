import UIKit
import ConfirmPasswordChange

struct ConfirmPasswordChangeBuilder {
  func build() -> UIViewController {
    let vc = ConfirmPasswordChangeViewController()
    vc.output = ConfirmPasswordChangeOutput(
      done: {

      }
    )

    return vc
  }
}

// MARK: - Routing

protocol ConfirmPasswordChangeRouting: Routing {
  func resetPassword()
  func passwordUpdated()
}

extension ConfirmPasswordChangeViewController: ConfirmPasswordChangeRouting {
  func user() {
    parent(of: RootRouting.self)?.user()
  }

  func guest() {
    parent(of: RootRouting.self)?.guest()
  }

  func resetPassword() {
    let builder = ChangePasswordBuilder(
      cancel: { [weak self] in
        self?.guest()
      }, next: { [weak self] in
        self?.passwordUpdated()
      })
    let vc = builder.build()

    show(vc: vc)
  }

  func passwordUpdated() {
    let builder = PasswordUpdatedBuilder(
      close: { [weak self] in
        self?.guest()
      },
      done: { [weak self] in
        self?.user()
      }
    )
    let vc = builder.build()

    show(vc: vc)
  }

}
