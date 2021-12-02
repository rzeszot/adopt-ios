import UIKit
import Root

typealias RootRouter = RootViewController

// MARK: -

protocol RootRouting: Routing {
  func guest()
  func user()
  func welcome()
}

extension RootRouter: RootRouting {
  func guest() {
    show(vc: GuestBuilder().build())
  }

  func user() {
    show(vc: UserBuilder().build())
  }

  func welcome() {
    show(vc: WelcomeBuilder().build())
  }

  // MARK: -

  func dispatch(_ command: RoutingCommand) {
    if let command = command as? ConfirmPasswordResetRoutingCommand {
      guest()
      (children.first as? Routing)?.dispatch(command)
    }
  }
}
