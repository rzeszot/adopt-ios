import UIKit
import Process

public struct Builder {
  public static func confirm(_ input: Input) -> UIViewController {
    #if DEBUG
      let client = StubClient()
    #else
      let client = RemoteClient(session: .shared)
    #endif

    let state = ChangePasswordState(username: input.username, code: input.code, client: client)

    let container = ContainerController()
    container.output = { state in
      input.close((state as! CloseState).reason)
    }
    container.start(state)

    return container
  }
}

#if DEBUG
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
#endif
