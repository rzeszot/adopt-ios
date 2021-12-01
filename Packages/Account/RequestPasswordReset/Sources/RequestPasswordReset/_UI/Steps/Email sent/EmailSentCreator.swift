import Process
import UIKit

struct EmailSentCreator: Creator {
  let gate: Gate

  func build(state: EmailSentState) -> UIViewController {
    let vc = EmailSentViewController()

    vc.viewModel = EmailSentViewModel(username: state.username)
    vc.output = EmailSentOutput(
      back: {
        gate.dispatch(.back)
      },
      submit: {
        gate.dispatch(.done)
      })

    return vc
  }
}
