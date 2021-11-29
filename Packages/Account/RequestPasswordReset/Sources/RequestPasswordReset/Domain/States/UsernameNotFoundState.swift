import Process
import UIKit

struct UsernameNotFoundState: State {
  let username: String
  let client: Client

  func ok() -> State {
    EnterUsernameState(username: username, client: client)
  }
}

extension UsernameNotFoundState: AnimatableState {
  func animatable(when destination: State) -> Bool {
    !(destination is EnterUsernameState)
  }
}
