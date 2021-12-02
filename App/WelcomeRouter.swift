import UIKit
import Welcome
import Privacy

typealias WelcomeRouter = WelcomeViewController

struct WelcomeBuilder {
  func build() -> UIViewController {
    let vc = WelcomeViewController()
    vc.action = { [unowned vc] action in
      switch action {
      case .done:
        vc.login()
      case .privacy:
        vc.privacy()
      }
    }
    return vc
  }
}

// MARK: - Routing

protocol WelcomeRouting: Routing {
  func privacy()
  func login()
}

extension WelcomeRouter: WelcomeRouting {
  func privacy() {
    let builder = PrivacyBuilder(dismiss: { self.dismiss(animated: true) })
    let vc = builder.build()

    present(vc, animated: true)
  }

  func login() {
    parent(of: RootRouting.self)?.guest()
  }
}
