import Process

struct EmailSentState: State {
  let username: String
  let client: Client

  func back() -> State {
    EnterUsernameState(username: username, client: client)
  }

  func done() -> State {
    CloseState(reason: .done)
  }
}
