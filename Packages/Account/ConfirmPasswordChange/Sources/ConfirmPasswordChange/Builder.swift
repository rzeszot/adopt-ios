import UIKit
import Process

public struct Builder {
  public static func confirm(_ input: Input) -> UIViewController {
    let container = ContainerController()
    let factory = Factory(transition: container.use, exit: { state in
      guard let state = state as? CloseState else { return }
      input.close(state.reason)
    })

    container.factory = factory

    factory.register(ChangePasswordCreator(gate: factory), for: ChangePasswordState.self)
    factory.register(PasswordUpdatedCreator(gate: factory), for: PasswordUpdatedState.self)
    factory.register(SubmitErrorCreator(gate: factory), for: SubmitErrorState.self)

    factory.transition(to: ChangePasswordState(username: input.username, code: input.code, client: StubClient()))

    return container
  }
}

struct StubClient: Client {
  typealias Failure = RemoteClient.FailureResponse

  func request(username: String, password: String, code: String) async throws {
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

extension SubmitErrorState: AnimatableState {
  func animatable(when destination: State) -> Bool {
    !(destination is ChangePasswordState)
  }
}

extension CloseState: ExitState {

}
