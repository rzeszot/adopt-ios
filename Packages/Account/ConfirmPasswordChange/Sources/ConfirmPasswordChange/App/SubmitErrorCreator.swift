import UIKit
import Process

struct SubmitErrorCreator: Creator {
  func build(state: SubmitErrorState, change: @escaping (State) -> Void) -> UIViewController {
    let title = t("confirm-password-change.submit-error.title")
    let message = t("confirm-password-change.submit-error.message")
      .replacingOccurrences(of: "#{username}", with: state.username)
    let ok = t("confirm-password-change.submit-error.ok-action")

    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: ok, style: .default) { _ in
      change(state.ok())
    })

    return alert
  }
}
