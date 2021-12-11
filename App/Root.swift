import UIKit
import Root

protocol RootRoutable: Routing {
  func guest()
  func user()
  func welcome()
}

extension RootViewController: RootRoutable {
  func welcome() {

  }

  func guest() {
    let (vc, router) = GuestBuilder().build()
    router.login()
    show(vc: vc)
  }

  func user() {

  }
}

// MARK: -

struct RootBuilder {
  func build() -> (UIViewController, RootRoutable) {
    let vc = RootViewController()
    return (vc, vc)
  }
}
