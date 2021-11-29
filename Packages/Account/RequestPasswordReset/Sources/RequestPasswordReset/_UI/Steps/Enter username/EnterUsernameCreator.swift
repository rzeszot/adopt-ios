import Process
import UIKit

struct EnterUsernameCreator: Creator {
  let gate: Gate

  func build(state: EnterUsernameState) -> UIViewController {
    let vc = EnterUsernameViewController()

    vc.viewModel = EnterUsernameViewModel(username: state.username)
    vc.output = EnterUsernameOutput(
      close: {
        gate.transition(to: state.close())
      }, submit: { username in
        gate.transition(to: await state.submit(username: username))
      })

    return vc
  }
}
