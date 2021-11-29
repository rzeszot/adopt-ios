import Process

struct PasswordUpdatedState: State {
  let username: String

  func dismiss() -> State {
    CloseState(reason: .dismiss)
  }

  func done() -> State {
    CloseState(reason: .authorize)
  }
}
