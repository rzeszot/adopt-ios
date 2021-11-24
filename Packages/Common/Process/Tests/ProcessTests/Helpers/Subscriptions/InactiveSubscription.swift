import Process

struct InactiveSubscription: State {
  let service = DelayService()

  func activate() async -> ActiveSubscription {
    await service.execute()
    return ActiveSubscription()
  }
}

extension InactiveSubscription: SpecificationState {
  func transitionable(to state: State) -> Bool {
    state is ActiveSubscription
  }
}

extension InactiveSubscription: CustomStringConvertible {
  var description: String {
    "inactive"
  }
}
