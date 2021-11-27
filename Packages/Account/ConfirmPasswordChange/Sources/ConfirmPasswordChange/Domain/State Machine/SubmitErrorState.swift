import Process

struct SubmitErrorState: State {
  let username: String
  let code: String
  let client: Client

  func ok() -> State {
    ChangePasswordState(username: username, code: code, client: client)
  }
}

extension SubmitErrorState: SpecificationState {
  func ignore(when destination: State) -> Bool {
    destination is ChangePasswordState
  }

  func transitionable(to destination: State) -> Bool {
    destination is ChangePasswordState
  }
}
