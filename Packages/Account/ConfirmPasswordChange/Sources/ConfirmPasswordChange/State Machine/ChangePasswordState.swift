import Process
import UIKit

struct ChangePasswordState: State {
  let username: String
  let code: String
  let client: Client

  func close() -> State {
    CloseState(reason: .cancel)
  }

  func submit(password: String) async -> State {
    do {
      try await client.request(username: username, password: password, code: code)
      return PasswordUpdatedState(username: username)
    } catch {
      return PasswordErrorState(username: username, code: code, client: client)
    }
  }
}

extension ChangePasswordState: SpecificationState {
  func transitionable(to state: State) -> Bool {
    state is CloseState || state is PasswordUpdatedState || state is PasswordErrorState
  }
}

extension ChangePasswordState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    let vc = ChangePasswordViewController()
    vc.output = ChangePasswordOutput(
      close: {
        change(self.close())
      }, submit: { password async in
        change(await self.submit(password: password))
      })
    return vc
  }
}

extension ChangePasswordState: CustomStringConvertible {
  var description: String {
    "change password"
  }
}
