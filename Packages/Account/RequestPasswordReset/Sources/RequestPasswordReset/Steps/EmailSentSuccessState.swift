import Process

struct EmailSentSuccessState: State {
  let context: RequestPasswordResetContext

  func back() -> State {
    EnterUsernameState(context: context)
  }

  func done() -> State {
    CloseState(context: context, reason: .done)
  }
}
