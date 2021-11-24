import Process
import UIKit

struct UsernameNotFoundState: State {
  let username: String
  let client: Client

  func ok() -> State {
    EnterUsernameState(username: username, client: client)
  }
}

extension UsernameNotFoundState: SpecificationState {
  func ignore(when destination: State) -> Bool {
    destination is EnterUsernameState
  }

  func transitionable(to state: State) -> Bool {
    state is EnterUsernameState
  }
}

extension UsernameNotFoundState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    let alert = UIAlertController(title: "TODO", message: "TODO \(username)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      change(self.ok())
    })
    return alert
  }
}

extension UsernameNotFoundState: CustomStringConvertible {
  var description: String {
    "not found"
  }
}
