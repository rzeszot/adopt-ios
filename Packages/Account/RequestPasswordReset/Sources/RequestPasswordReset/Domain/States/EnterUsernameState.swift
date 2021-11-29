import Process

struct EnterUsernameState: InitialState {
  let username: String?
  let client: Client

  func close() -> State {
    CloseState(reason: .cancel)
  }

  func submit(username: String) async -> State {
    do {
      try await client.request(username: username)
      return EmailSentState(username: username, client: client)
    } catch {
      return UsernameNotFoundState(username: username, client: client)
    }
  }
}
