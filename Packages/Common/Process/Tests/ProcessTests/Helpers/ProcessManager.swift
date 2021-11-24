import Process

extension ProcessManager {
  static func subscriptions() -> ProcessManager {
    let manager = ProcessManager()

    try! manager.register { (state: ActiveSubscription, command: DeactivateCommand) in
      await state.deactivate()
    }
    try! manager.register { (state: InactiveSubscription, command: ActivateCommand) in
      await state.activate()
    }
    try! manager.register { (state: ActiveSubscription, command: PauseCommand) in
      await state.pause()
    }
    try! manager.register { (state: PausedSubscription, command: ResumeCommand) in
      await state.resume()
    }

    try! manager.register { (state: RandomSubscription, command: RandomCommand) in
      await state.random()
    }

    return manager
  }
}
