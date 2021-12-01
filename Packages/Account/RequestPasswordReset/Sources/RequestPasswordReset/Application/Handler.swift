import Process

class Handler {
  private(set) var state: State

  init(state: State) {
    self.state = state
  }

  @MainActor
  func handle(_ command: Command) async throws {
    state = try await next(state: state, command: command)
  }

  private func next(state: State, command: Command) async throws -> State {
    switch (state, command) {

    case (let state as  EnterUsernameState, .cancel):
      return state.cancel()
    case (let state as EnterUsernameState, .submit(let username)):
      return await state.submit(username: username)

    case (let state as EmailSentState, .back):
      return state.back()
    case (let state as EmailSentState, .done):
      return state.done()

    case (let state as UsernameNotFoundState, .ok):
      return state.ok()

    default:
      throw InvalidTransitionError(state: state, command: command)
    }
  }

}
