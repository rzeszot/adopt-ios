import Process

struct SubmitErrorState: State {
  let username: String
  let code: String
  let client: Client

  func ok() -> State {
    ChangePasswordState(username: username, code: code, client: client)
  }

}
