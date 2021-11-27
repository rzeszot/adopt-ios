import Process
import UIKit

struct EmailSentState: State {
  let username: String
  let client: Client

  func back() -> State {
    EnterUsernameState(username: username, client: client)
  }

  func done() -> State {
    CloseState(reason: .done)
  }
}

extension EmailSentState: SpecificationState {
  func transitionable(to state: State) -> Bool {
    state is EnterUsernameState || state is CloseState
  }
}

extension EmailSentState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    let vc = EmailSentViewController()
    vc.viewModel = EmailSentViewModel(username: username)
    vc.output = EmailSentOutput(
      back: {
        change(self.back())
      },
      submit: {
        change(self.done())
      })
    return vc
  }
}
