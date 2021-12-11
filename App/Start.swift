import UIKit
import Root
import Welcome
import Guest
import User

struct CompositionRoot {
  let root = RootBuilder()

  func start() {

  }

  func build() -> UIViewController {
    let (vc, router) = root.build()
    router.guest()
    return vc
  }
}
