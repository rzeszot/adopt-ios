import Foundation


struct CloseStep {
  let reason: Input.CloseReason
}


struct EnterUsernameStep {
  func close() -> CloseStep {
    CloseStep(reason: .cancel)
  }

  func submit(username: String) -> EmailSentStep {
    EmailSentStep()
  }
}


struct EmailSentStep {
  func back() -> EnterUsernameStep {
    EnterUsernameStep()
  }

  func done() -> CloseStep {
    CloseStep(reason: .done)
  }
}



class RequestPasswordResetProcess {

}
