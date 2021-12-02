import UIKit
import Root
import Welcome
import Guest
import User

struct CompositionRoot {
  let router = RootRouter()

  func start() {
//    (router as RootRouting).dispatch(ConfirmPasswordResetRoutingCommand())
    router.welcome()
  }

  func build() -> UIViewController {
    router
  }
}

struct ConfirmPasswordResetRoutingCommand: RoutingCommand {

}
