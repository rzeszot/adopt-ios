import Process

struct PausedSubscription: State {
  let service = DelayService()

  func resume() async -> ActiveSubscription {
    await service.execute()
    return ActiveSubscription()
  }
}
