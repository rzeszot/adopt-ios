import UIKit
import Process

struct ChangePasswordCreator: Creator {
  func build(state: ChangePasswordState, change: @escaping (State) -> Void) -> UIViewController {
    let vc = ChangePasswordViewController()
    vc.output = ChangePasswordOutput(
      close: {
        change(state.close())
      }, submit: { password async in
        await change(state.submit(password: password))
      })
    return vc
  }
}
