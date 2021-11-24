import XCTest
import Process
@testable import RequestPasswordReset

final class RequestPasswordResetProcessManagerTests: XCTestCase {
  var sut: ProcessManager!

  override func setUp() {
    sut = .requestPasswordReset()
  }

  override func tearDown() {
    sut = nil
  }

  // MARK: -

  func test_enter_username_do_close_to_close_state() async throws {
    sut.start { EnterUsernameState() }
    try await sut.handle(CloseCommand())
    XCTAssertTrue(sut.current is CloseState)
  }

  func test_enter_username_do_submit_to_email_sent_state() async throws {
    sut.start { EnterUsernameState() }
    try await sut.handle(SubmitUsernameCommand(username: "username@example.org"))
    XCTAssertTrue(sut.current is EmailSentState)
  }

  func test_enter_username_do_back_to_invalid() async throws {
    sut.start { EnterUsernameState() }
    do {
      try await sut.handle(BackCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_enter_username_do_done_to_invalid() async throws {
    sut.start { EnterUsernameState() }
    do {
      try await sut.handle(DoneCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  // MARK: -

  func test_email_sent_do_back_to_enter_username_state() async throws {
    sut.start { EmailSentState() }
    try await sut.handle(BackCommand())
    XCTAssertTrue(sut.current is EnterUsernameState)
  }

  func test_email_sent_do_done_to_close_state() async throws {
    sut.start { EmailSentState() }
    try await sut.handle(DoneCommand())
    XCTAssertEqual((sut.current as? CloseState)?.reason, .done)
  }

  func test_email_sent_do_close_to_invalid() async throws {
    sut.start { EmailSentState() }
    do {
      try await sut.handle(CloseCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_email_sent_do_submit_to_invalid() async throws {
    sut.start { EmailSentState() }
    do {
      try await sut.handle(SubmitUsernameCommand(username: "username@example.org"))
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

}
