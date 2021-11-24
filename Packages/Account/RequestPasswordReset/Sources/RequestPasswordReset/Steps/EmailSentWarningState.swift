import Process

struct EmailSentWarningState: State {
  let context: RequestPasswordResetContext

  func ok() -> State {
    EnterUsernameState(context: context)
  }
}
