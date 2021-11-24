import Process

struct InactiveSubscription: State {
  let service = DelayService()

  func activate() async -> ActiveSubscription {
    await service.execute()
    return ActiveSubscription()
  }
}
