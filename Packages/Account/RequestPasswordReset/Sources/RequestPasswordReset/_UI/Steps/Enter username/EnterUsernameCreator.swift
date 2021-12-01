import Process
import UIKit

struct EnterUsernameCreator: Creator {
  let gate: Gate

  func build(state: EnterUsernameState) -> UIViewController {
    let vc = EnterUsernameViewController()

    vc.viewModel = EnterUsernameViewModel(username: state.username)
    vc.output = EnterUsernameOutput(
      close: {
        gate.dispatch(.cancel)
      }, submit: { username in
        gate.dispatch(.submit(username: username))
      })

    return vc
  }
}
