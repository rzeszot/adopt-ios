import User
import UIKit

typealias UserRouter = UserViewController

struct UserBuilder {
  func build() -> UIViewController {
    let vc = UserViewController()
    vc.submit = vc.login
    return vc
  }
}

// MARK: - Routing

protocol UserRouting: Routing {
  func login()
  func main()
}

extension UserRouter: UserRouting {
  func login() {
    parent(of: RootRouting.self)?.guest()
  }

  func main() {

  }
}
