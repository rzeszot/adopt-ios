import XCTest
import Process

final class SubscriptionsStateMachineTests: XCTestCase {

  // MARK: - Active

  func test_active_transitionable() {
    let sut = ActiveSubscription()

    XCTAssertTrue(sut.transitionable(to: InactiveSubscription()))
    XCTAssertTrue(sut.transitionable(to: PausedSubscription()))

    XCTAssertFalse(sut.transitionable(to: ActiveSubscription()))
    XCTAssertFalse(sut.transitionable(to: RandomSubscription()))
  }

  func test_active_do_deactivate_to_inactive() async {
    let sut = ActiveSubscription()
    let result = await sut.deactivate()
    XCTAssertEqual(String(describing: result), "inactive")
  }

  func test_active_do_pause_to_paused() async {
    let sut = ActiveSubscription()
    let result = await sut.pause()
    XCTAssertEqual(String(describing: result), "paused")
  }

  // MARK: - Inactive

  func test_inactive_transitionable() {
    let sut = InactiveSubscription()

    XCTAssertTrue(sut.transitionable(to: ActiveSubscription()))

    XCTAssertFalse(sut.transitionable(to: PausedSubscription()))
    XCTAssertFalse(sut.transitionable(to: RandomSubscription()))
    XCTAssertFalse(sut.transitionable(to: InactiveSubscription()))
  }

  func test_inactive_do_activate_to_active() async {
    let sut = InactiveSubscription()
    let result = await sut.activate()
    XCTAssertEqual(String(describing: result), "active")
  }

  // MARK: - Paused

  func test_paused_transitionable() {
    let sut = PausedSubscription()

    XCTAssertTrue(sut.transitionable(to: ActiveSubscription()))

    XCTAssertFalse(sut.transitionable(to: InactiveSubscription()))
    XCTAssertFalse(sut.transitionable(to: PausedSubscription()))
    XCTAssertFalse(sut.transitionable(to: RandomSubscription()))
  }

  func test_paused_do_resume_to_active() async {
    let sut = PausedSubscription()
    let result = await sut.resume()
    XCTAssertEqual(String(describing: result), "active")
  }

  // MARK: - Random

  func test_random_transitionable() {
    let sut = RandomSubscription()

    XCTAssertTrue(sut.transitionable(to: ActiveSubscription()))
    XCTAssertTrue(sut.transitionable(to: InactiveSubscription()))

    XCTAssertFalse(sut.transitionable(to: PausedSubscription()))
    XCTAssertFalse(sut.transitionable(to: RandomSubscription()))
  }

  func test_random_do_random_true_to_active() async {
    let sut = RandomSubscription()
    sut.service.returns = true
    let result = await sut.random()
    XCTAssertEqual(String(describing: result), "active")
  }

  func test_random_do_random_false_to_inactive() async {
    let sut = RandomSubscription()
    sut.service.returns = false
    let result = await sut.random()
    XCTAssertEqual(String(describing: result), "inactive")
  }

  // MARK: - SomeState

  func test_ignore_false_by_default() {
    let sut = SomeState()
    XCTAssertFalse(sut.ignore(when: SomeState()))
  }

  func test_transitionable_true_by_default() {
    let sut = SomeState()
    XCTAssertTrue(sut.transitionable(to: SomeState()))
  }

}
