import Foundation
import Process

// MARK: - Commands

struct CloseCommand: Command {

}

struct BackCommand: Command {

}

struct DoneCommand: Command {

}

struct SubmitUsernameCommand: Command {
  let username: String
}

// MARK: - States

struct CloseState: State {
  let reason: Input.CloseReason
}

struct EnterUsernameState: State {
  func close() -> State {
    CloseState(reason: .cancel)
  }

  func submit(username: String) -> State {
    EmailSentState()
  }
}

struct EmailSentState: State {
  func back() -> State {
    EnterUsernameState()
  }

  func done() -> State {
    CloseState(reason: .done)
  }
}

// MARK: -

extension ProcessManager {
  static func requestPasswordReset() -> ProcessManager {
    let manager = ProcessManager()

    manager.start {
      EnterUsernameState()
    }

    try! manager.register { (step: EnterUsernameState, command: CloseCommand) in
      step.close()
    }
    try! manager.register { (step: EnterUsernameState, command: SubmitUsernameCommand) in
      step.submit(username: command.username)
    }

    try! manager.register { (step: EmailSentState, command: BackCommand) in
      step.back()
    }
    try! manager.register { (step: EmailSentState, command: DoneCommand) in
      step.done()
    }

    return manager
  }
}
