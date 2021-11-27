import UIKit
import Process

struct PasswordUpdatedCreator: Creator {
  func build(state: PasswordUpdatedState, change: @escaping (State) -> Void) -> UIViewController {
    let vc = PasswordUpdatedViewController()
    vc.viewModel = PasswordUpdatedViewModel(username: state.username)
    vc.output = PasswordUpdatedOutput(
      close: {
        change(state.dismiss())
      }, done: {
        change(state.done())
      })
    return vc
  }
}
