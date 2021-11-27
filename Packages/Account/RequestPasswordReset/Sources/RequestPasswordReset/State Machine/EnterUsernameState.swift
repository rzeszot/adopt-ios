import Process
import UIKit

struct EnterUsernameState: State {
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

  static func initial(username: String?, client: Client) -> EnterUsernameState {
    EnterUsernameState(username: username, client: client)
  }
}

extension EnterUsernameState: SpecificationState {
  func transitionable(to state: State) -> Bool {
    state is EmailSentState || state is UsernameNotFoundState || state is CloseState
  }
}

extension EnterUsernameState: VisualState {
  func build(change: @escaping (State) -> Void) -> UIViewController {
    let vc = EnterUsernameViewController()
    vc.viewModel = EnterUsernameViewModel(username: username)
    vc.output = EnterUsernameOutput(
      close: {
        change(self.close())
      }, submit: { username in
        change(await self.submit(username: username))
      })
    return vc
  }
}
