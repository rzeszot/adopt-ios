import Process

struct ActiveSubscription: State {
  let service = DelayService()

  func deactivate() async -> InactiveSubscription {
    await service.execute()
    return InactiveSubscription()
  }

  func pause() async -> PausedSubscription {
    await service.execute()
    return PausedSubscription()
  }
}

extension ActiveSubscription: SpecificationState {
  func transitionable(to state: State) -> Bool {
    state is InactiveSubscription || state is PausedSubscription
  }
}
