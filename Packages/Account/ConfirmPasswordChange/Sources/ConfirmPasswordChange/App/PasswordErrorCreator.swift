import UIKit
import Process

struct PasswordErrorCreator: Creator {
  func build(state: PasswordErrorState, change: @escaping (State) -> Void) -> UIViewController {
    let alert = UIAlertController(title: "TODO", message: "TODO \(state.username)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      change(state.ok())
    })
    return alert
  }
}
