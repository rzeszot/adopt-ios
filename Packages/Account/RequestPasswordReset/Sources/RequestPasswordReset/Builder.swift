import UIKit
import Process

public struct Builder {
  public static func request(_ input: Input) -> UIViewController {
    let state = EnterUsernameState.stub(username: input.username)

    let container = ContainerController()
    container.output = { state in
      input.close((state as! CloseState).reason)
    }
    container.start(state)

    return container
  }
}

extension EnterUsernameState {
  static func stub(username: String?) -> EnterUsernameState {
    .initial(username: username, client: RequestPasswordResetClientStub())
  }
}

struct RequestPasswordResetClientStub: Client {
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
