import Foundation
@testable import RequestPasswordReset

extension EnterUsernameState {
  static func sut(username: String? = "hello", response: Behaviour = .fatal) -> EnterUsernameState {
    EnterUsernameState(username: username, client: ClientMock(behaviour: response))
  }
}

extension UsernameNotFoundState {
  static func sut(username: String = "hello", response: Behaviour = .fatal) -> UsernameNotFoundState {
    UsernameNotFoundState(username: username, client: ClientMock(behaviour: response))
  }
}

extension EmailSentState {
  static func sut(username: String = "hello", response: Behaviour = .fatal) -> EmailSentState {
    EmailSentState(username: username, client: ClientMock(behaviour: response))
  }
}
