import UIKit
import Main

struct MainRouter {

}

// MARK: - Routing

protocol MainRouting: Routing {
  func dashboard()
  func profile()
}

extension MainRouter: MainRouting {
  func dashboard() {

  }

  func profile() {

  }
}
