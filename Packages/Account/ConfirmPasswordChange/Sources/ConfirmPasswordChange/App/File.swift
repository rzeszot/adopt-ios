import UIKit
import Process


extension ChangePasswordState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    let vc = ChangePasswordViewController()
    vc.output = ChangePasswordOutput(
      close: {
        change(self.close())
      }, submit: { password async in
        change(await self.submit(password: password))
      })
    return vc
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
