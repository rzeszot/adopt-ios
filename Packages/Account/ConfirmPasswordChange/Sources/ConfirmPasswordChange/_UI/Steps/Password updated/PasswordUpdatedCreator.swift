import UIKit
import Process

struct PasswordUpdatedCreator: Creator {
  let gate: Gate

  func build(state: PasswordUpdatedState) -> UIViewController {
    let vc = PasswordUpdatedViewController()

    vc.viewModel = PasswordUpdatedViewModel(username: state.username)
    vc.output = PasswordUpdatedOutput(
      close: {
        gate.transition(to: state.dismiss())
      }, done: {
        gate.transition(to: state.done())
      })

    return vc
  }
}
