import UIKit
import Profile

struct ProfileRouter {

}

// MARK: -

protocol ProfileRouting: Routing {
  func settings()
}

extension ProfileRouter: ProfileRouting {
  func settings() {

  }
}
