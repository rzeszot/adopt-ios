import Process
import UIKit

struct UsernameNotFoundCreator: Creator {
  let gate: Gate

  func build(state: UsernameNotFoundState) -> UIViewController {
    let alert = UIAlertController(title: "TODO", message: "TODO \(state.username)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      gate.dispatch(.ok)
    })

    return alert
  }
}
