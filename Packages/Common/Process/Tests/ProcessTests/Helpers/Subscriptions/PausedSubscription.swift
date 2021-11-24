import Process

struct PausedSubscription: State {
  let service = DelayService()

  func resume() async -> ActiveSubscription {
    await service.execute()
    return ActiveSubscription()
  }
}

extension PausedSubscription: SpecificationState {
  func transitionable(to state: State) -> Bool {
    state is ActiveSubscription
  }
}

extension PausedSubscription: CustomStringConvertible {
  var description: String {
    "paused"
  }
}
