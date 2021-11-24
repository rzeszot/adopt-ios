import Process
import UIKit

struct PasswordErrorState: State {
  let username: String
  let code: String
  let client: Client

  func ok() -> State {
    ChangePasswordState(username: username, code: code, client: client)
  }
}

extension PasswordErrorState: SpecificationState {
  func ignore(when destination: State) -> Bool {
    destination is ChangePasswordState
  }

  func transitionable(to state: State) -> Bool {
    state is ChangePasswordState
  }
}

extension PasswordErrorState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    let alert = UIAlertController(title: "TODO", message: "TODO \(username)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      change(self.ok())
    })
    return alert
  }
}

extension PasswordErrorState: CustomStringConvertible {
  var description: String {
    "password error"
  }
}
