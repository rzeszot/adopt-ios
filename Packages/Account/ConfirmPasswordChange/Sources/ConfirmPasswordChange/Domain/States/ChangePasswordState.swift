import Process

struct ChangePasswordState: InitialState {
  let username: String
  let code: String
  let client: Client

  func cancel() -> State {
    CloseState(reason: .cancel)
  }

  func submit(password: String) async -> State {
    do {
      try await request(password: password)
      return PasswordUpdatedState(username: username)
    } catch {
      return SubmitErrorState(username: username, code: code, client: client)
    }
  }

  private func request(password: String) async throws {
    try await client.request(username: username, password: password, code: code)
  }
}
