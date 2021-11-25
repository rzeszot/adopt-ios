import Process
import UIKit

struct PasswordUpdatedState: State {
  let username: String

  func dismiss() -> State {
    CloseState(reason: .dismiss)
  }

  func done() -> State {
    CloseState(reason: .authorize)
  }
}

extension PasswordUpdatedState: SpecificationState {
  func transitionable(to state: State) -> Bool {
    state is CloseState
  }
}

extension PasswordUpdatedState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    let vc = PasswordUpdatedViewController()
    vc.viewModel = PasswordUpdatedViewModel(username: username)
    vc.output = PasswordUpdatedOutput(
      close: {
        change(self.dismiss())
      }, done: {
        change(self.done())
      })
    return vc
  }
}

extension PasswordUpdatedState: CustomStringConvertible {
  var description: String {
    "password updated"
  }
}
