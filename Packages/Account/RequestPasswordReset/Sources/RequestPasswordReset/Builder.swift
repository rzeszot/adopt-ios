import UIKit
import Process

public struct Builder {
  public static func request(_ input: Input) -> UIViewController {
    let container = ContainerController()
    let factory = Factory(transition: container.use, exit: { state in
      guard let state = state as? CloseState else { return }
      input.close(state.reason)
    })

    factory.register(EnterUsernameCreator(gate: factory), for: EnterUsernameState.self)
    factory.register(EmailSentCreator(gate: factory), for: EmailSentState.self)
    factory.register(UsernameNotFoundCreator(gate: factory), for: UsernameNotFoundState.self)

    factory.transition(to: EnterUsernameState(username: input.username, client: StubClient()))

    container.factory = factory
    return container
  }
}

struct StubClient: Client {
  typealias Failure = RemoteClient.FailureResponse

  func request(username: String) async throws {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<(), Error>) in
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(900)) {
        if Bool.random() {
          continuation.resume()
        } else {
          continuation.resume(with: .failure(Failure()))
        }
      }
    }
  }
}
