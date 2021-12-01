import UIKit
import Process

public struct Builder {
  public static func request(_ input: Input) -> UIViewController {
    let initial = EnterUsernameState(username: input.username, client: StubClient())

    let container = ContainerController()
    container.handler = Handler(state: initial)
    container.close = input.close

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
