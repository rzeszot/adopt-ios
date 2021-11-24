import Process

protocol RequestPasswordResetClient {
  func request(username: String) async throws
}

struct EnterUsernameState: State {
  let context: RequestPasswordResetContext

  init(context: RequestPasswordResetContext) {
    self.context = context  }

  func close() -> State {
    CloseState(context: context, reason: .cancel)
  }

  func submit(username: String) async -> State {
    do {
      try await context.client.request(username: username)
      return EmailSentSuccessState(context: context)
    } catch {
      return EmailSentWarningState(context: context)
    }
  }

}
