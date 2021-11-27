import UIKit
import Process

public struct Builder {
  public static func confirm(_ input: Input) -> UIViewController {
    let state = ChangePasswordState.stub(username: input.username, code: input.code)

    let container = ContainerController()
    container.output = { state in
      input.close((state as! CloseState).reason)
    }
    container.start(state)

    return container
  }
}

extension ChangePasswordState {
  static func stub(username: String, code: String) -> ChangePasswordState {
    ChangePasswordState(username: username, code: code, client: StubClient())
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
