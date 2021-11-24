import UIKit
import Process


struct RequestPasswordResetClientMock: RequestPasswordResetClient {
  typealias Failure = RequestPasswordResetService.FailureResponse

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


extension ProcessManager {
  static func requestPasswordReset() -> ProcessManager {
    let manager = ProcessManager()
    let context = RequestPasswordResetContext(client: RequestPasswordResetClientMock())

    manager.start {
      EnterUsernameState(context: context)
    }

    try! manager.register { (step: EnterUsernameState, command: CloseCommand) in
      step.close()
    }
    try! manager.register { (step: EnterUsernameState, command: SubmitUsernameCommand) in
      await step.submit(username: command.username)
    }

    try! manager.register { (step: EmailSentSuccessState, command: BackCommand) in
      step.back()
    }
    try! manager.register { (step: EmailSentSuccessState, command: DoneCommand) in
      step.done()
    }

    try! manager.register { (step: EmailSentWarningState, command: OkCommand) in
      step.ok()
    }

    return manager
  }
}
