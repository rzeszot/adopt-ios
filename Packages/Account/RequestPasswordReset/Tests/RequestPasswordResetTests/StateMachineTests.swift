import XCTest
import Process
@testable import RequestPasswordReset

final class StateMachineTests: XCTestCase {

  // MARK: - EnterUsernameState

  func test_EnterUsernameState_cancel() async throws {
    let sut = Handler(state: EnterUsernameState.sut())
    try await sut.handle(.cancel)
    XCTAssertTrue(sut.state is CloseState)
  }

  func test_EnterUsernameState_submit_success() async throws {
    let sut = Handler(state: EnterUsernameState.sut(response: .success))
    try await sut.handle(.submit(username: "user"))
    XCTAssertTrue(sut.state is EmailSentState)
  }

  func test_EnterUsernameState_submit_failure() async throws {
    let sut = Handler(state: EnterUsernameState.sut(response: .failure))
    try await sut.handle(.submit(username: "user"))
    XCTAssertTrue(sut.state is UsernameNotFoundState)
  }

  // MARK: - EmailSentState

  func test_EmailSentState_done() async throws {
    let sut = Handler(state: EmailSentState.sut())
    try await sut.handle(.done)
    XCTAssertTrue(sut.state is CloseState)
  }

  func test_EmailSentState_back() async throws {
    let sut = Handler(state: EmailSentState.sut())
    try await sut.handle(.back)
    XCTAssertTrue(sut.state is EnterUsernameState)
  }

  // MARK: - UsernameNotFoundState

  func test_UsernameNotFoundState_ok() async throws {
    let sut = Handler(state: UsernameNotFoundState.sut())
    try await sut.handle(.ok)
    XCTAssertTrue(sut.state is EnterUsernameState)
  }

  // MARK: -

  func test_EnterUsernameState_ok() async throws {
    let sut = Handler(state: EnterUsernameState.sut())
    do {
      try await sut.handle(.ok)
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

}
