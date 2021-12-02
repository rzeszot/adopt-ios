import UIKit
import RequestPasswordChange

struct EmailSentBuilder {
  let dismiss: () -> Void

  public init(dismiss: @escaping () -> Void) {
    self.dismiss = dismiss
  }

  func build() -> UIViewController {
    let vc = EmailSentViewController()
    vc.viewModel = EmailSentViewModel(username: "xxx")
    vc.output = EmailSentOutput(
      back: { [weak vc] in
        vc?.enterUsername()
      },
      done: dismiss
    )

    return vc
  }
}

// MARK: - Routing

protocol EmailSentRouting: Routing {
  func enterUsername()
}

extension EmailSentViewController: EmailSentRouting {
  func enterUsername() {
    parent(of: RequestPasswordChangeRouting.self)?.enterUsername()
  }
}
