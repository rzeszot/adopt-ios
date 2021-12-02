import UIKit
import RequestPasswordChange

struct RequestPasswordChangeBuilder {
  let username: String?
  let dismiss: () -> Void

  public init(username: String?, dismiss: @escaping () -> Void) {
    self.username = username
    self.dismiss = dismiss
  }

  func build() -> UIViewController {
    let vc = RequestPasswordChangeViewController()
    vc.output = RequestPasswordChangeOutput(
      dismiss: {
        self.dismiss()
      }
    )

    return vc
  }
}

// MARK: - Routing

protocol RequestPasswordChangeRouting: Routing {
  func enterUsername()
  func emailSent()
}

extension RequestPasswordChangeViewController: RequestPasswordChangeRouting {
  func enterUsername() {
    let builder = EnterUsernameBuilder(username: nil) { [weak self] in
      self?.output.dismiss()
    }
    let vc = builder.build()

    show(vc: vc)
  }

  func emailSent() {
    let builder = EmailSentBuilder { [weak self] in
      self?.output.dismiss()
    }
    let vc = builder.build()

    show(vc: vc)
  }
}
