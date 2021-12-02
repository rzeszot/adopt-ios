import UIKit
import Settings

typealias SettingsRouter = SettingsViewController

// MARK: - Routing

protocol SettingsRouting: Routing {
  func login()
}

extension SettingsRouter: SettingsRouting {


  func login() {
    parent(of: RootRouting.self)?.guest()
  }
}
