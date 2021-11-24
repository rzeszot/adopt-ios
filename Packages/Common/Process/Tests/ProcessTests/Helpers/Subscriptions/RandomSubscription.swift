import Process

struct RandomSubscription: State {
  let service = DelayService()

  func random() async -> State {
    if await service.execute() {
      return ActiveSubscription()
    } else {
      return InactiveSubscription()
    }
  }
}
