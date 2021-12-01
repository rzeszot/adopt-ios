import UIKit
import Process

//struct SubmitErrorCreator: Creator {
//  let gate: Gate
//
//  func build(state: SubmitErrorState) -> UIViewController {
//    let title = t("confirm-password-change.submit-error.title")
//    let message = t("confirm-password-change.submit-error.message")
//      .replacingOccurrences(of: "#{username}", with: state.username)
//    let ok = t("confirm-password-change.submit-error.ok-action")
//
//    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: ok, style: .default) { _ in
//      gate.transition(to: state.ok())
//    })
//
//    return alert
//  }
//}
