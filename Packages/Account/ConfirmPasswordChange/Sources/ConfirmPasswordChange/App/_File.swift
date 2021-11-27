import UIKit
import Process


extension ChangePasswordState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    ChangePasswordCreator().build(state: self, change: change)
  }
}

extension PasswordErrorState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    PasswordErrorCreator().build(state: self, change: change)
  }
}

extension PasswordUpdatedState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    PasswordUpdatedCreator().build(state: self, change: change)
  }
}
