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

  func test_enter_username_do_close_to_close() async throws {
    sut.start { EnterUsernameState() }
    try await sut.handle(CloseCommand())
    XCTAssertTrue(sut.current is CloseState)
  }

  func test_enter_username_do_submit_success_to_email_sent_success() async throws {
    sut.start { EnterUsernameState(service: RequestPasswordResetClientMock(success: true)) }
    try await sut.handle(SubmitUsernameCommand(username: "username@example.org"))
    XCTAssertTrue(sut.current is EmailSentSuccessState)
  }

  func test_enter_username_do_submit_failure_to_email_sent_warning() async throws {
    sut.start { EnterUsernameState(service: RequestPasswordResetClientMock(success: false)) }
    try await sut.handle(SubmitUsernameCommand(username: "username@example.org"))
    XCTAssertTrue(sut.current is EmailSentWarningState)
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

  func test_email_sent_warning_do_ok_to_enter_username() async throws {
    sut.start { EmailSentWarningState() }
    try await sut.handle(OkCommand())
    XCTAssertTrue(sut.current is EnterUsernameState)
  }

  // MARK: -

  func test_email_sent_success_do_back_to_enter_username() async throws {
    sut.start { EmailSentSuccessState() }
    try await sut.handle(BackCommand())
    XCTAssertTrue(sut.current is EnterUsernameState)
  }

  func test_email_sent_success_do_done_to_close() async throws {
    sut.start { EmailSentSuccessState() }
    try await sut.handle(DoneCommand())
    XCTAssertEqual((sut.current as? CloseState)?.reason, .done)
  }

  func test_email_sent_success_do_close_to_invalid() async throws {
    sut.start { EmailSentSuccessState() }
    do {
      try await sut.handle(CloseCommand())
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

  func test_email_sent_success_do_submit_to_invalid() async throws {
    sut.start { EmailSentSuccessState() }
    do {
      try await sut.handle(SubmitUsernameCommand(username: "username@example.org"))
      XCTFail()
    } catch {
      XCTAssertTrue(error is InvalidTransitionError)
    }
  }

}
