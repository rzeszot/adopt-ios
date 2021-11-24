import XCTest
import Process

final class ProcessManagerTests: XCTestCase {

  var sut: ProcessManager!

  override func setUp() {
    sut = .subscriptions()
  }

  override func tearDown() {
    sut = nil
  }

  // MARK: -

  func test_duplicated_transition() {
    do {
      try sut.register { (state: ActiveSubscription, _: DeactivateCommand) in
        await state.deactivate()
      }
      XCTFail()
    } catch {
      XCTAssertTrue(error is DuplicatedTransitionError)
    }
  }

  // MARK: - from: ActiveSubscription

  func test_active_subscription_deactivate_to_inactive_subscription() async throws {
    sut.start { ActiveSubscription() }
    try await sut.handle(DeactivateCommand())
    XCTAssertTrue(sut.current is InactiveSubscription)
  }

  func test_active_subscription_pause_to_paused_subscription() async throws {
    sut.start { ActiveSubscription() }
    try await sut.handle(PauseCommand())
    XCTAssertTrue(sut.current is PausedSubscription)
  }

  func test_active_subscription_resume_invalid() async {
    sut.start { ActiveSubscription() }
    do {
      try await sut.handle(ResumeCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_active_subscription_activate_invalid() async {
    sut.start { ActiveSubscription() }
    do {
      try await sut.handle(ActivateCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  // MARK: - from: InactiveSubscription

  func test_inactive_subscription_activate_to_active_subscription() async throws {
    sut.start { InactiveSubscription() }
    try await sut.handle(ActivateCommand())
    XCTAssertTrue(sut.current is ActiveSubscription)
  }

  func test_inactive_subscription_pause_to_paused_subscription() async throws {
    sut.start { InactiveSubscription() }
    do {
      try await sut.handle(PauseCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_inactive_subscription_resume_invalid() async {
    sut.start { InactiveSubscription() }
    do {
      try await sut.handle(ResumeCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_inactive_subscription_deactivate_invalid() async {
    sut.start { InactiveSubscription() }
    do {
      try await sut.handle(DeactivateCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  // MARK: - from: PausedSubscription

  func test_paused_subscription_resume_invalid() async throws {
    sut.start { PausedSubscription() }
    try await sut.handle(ResumeCommand())
    XCTAssertTrue(sut.current is ActiveSubscription)
  }

  func test_paused_subscription_activate_to_active_subscription() async {
    sut.start { PausedSubscription() }
    do {
      try await sut.handle(ActivateCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_paused_subscription_pause_to_paused_subscription() async {
    sut.start { PausedSubscription() }
    do {
      try await sut.handle(PauseCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_paused_subscription_deactivate_invalid() async {
    sut.start { PausedSubscription() }
    do {
      try await sut.handle(DeactivateCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  // MARK: - from: RandomSubscription

  func test_random_subscription_random_true_to_active_subscription() async throws {
    sut.start { RandomSubscription() }
    (sut.current as? RandomSubscription)?.service.returns = true
    try await sut.handle(RandomCommand())
    XCTAssertTrue(sut.current is ActiveSubscription)
  }

  func test_random_subscription_random_false_to_inactive_subscription() async throws {
    sut.start { RandomSubscription() }
    (sut.current as? RandomSubscription)?.service.returns = false
    try await sut.handle(RandomCommand())
    XCTAssertTrue(sut.current is InactiveSubscription)
  }

}
