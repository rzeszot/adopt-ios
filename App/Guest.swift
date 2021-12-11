import UIKit
import Guest

protocol GuestRoutable: UpstreamRouting {
  func login()
}

// MARK: -

extension GuestViewController: GuestRoutable {
  func login() {
    let builder = LoginBuilder()
    let vc = builder.build()
    show(vc: vc)
  }

  private var root: RootRoutable? {
    upstream(of: RootRoutable.self)
  }
}

// MARK: -

struct GuestBuilder {
  func build() -> (UIViewController, GuestRoutable) {
    let vc = GuestViewController()
    return (vc, vc)
  }
}
