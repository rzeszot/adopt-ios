import XCTest
@testable import RequestPasswordReset

final class StatesTests: XCTestCase {

  func test_enter_username_do_close_to_close() {
    let sut = EnterUsernameState.sut()
    let result = sut.cancel()
    XCTAssertEqual((result as? CloseState)?.reason, .cancel)
  }

  func test_enter_username_do_submit_success_to_email_sent_success() async {
    let sut = EnterUsernameState.sut(username: "first", response: .success)
    let result = await sut.submit(username: "second")
    XCTAssertEqual((result as? EmailSentState)?.username, "second")
  }

  func test_enter_username_do_submit_failure_to_email_sent_warning() async {
    let sut = EnterUsernameState.sut(username: "first", response: .failure)
    let result = await sut.submit(username: "second")
    XCTAssertEqual((result as? UsernameNotFoundState)?.username, "second")
  }

  func test_email_sent_warning_do_ok_to_enter_username() async {
    let sut = UsernameNotFoundState.sut(username: "first")
    let result = sut.ok()
    XCTAssertEqual((result as? EnterUsernameState)?.username, "first")
  }

  func test_email_sent_success_do_done_to_close() {
    let sut = EmailSentState.sut()
    let result = sut.done()
    XCTAssertEqual((result as? CloseState)?.reason, .done)
  }

  func test_email_sent_success_do_back_to_enter_username() {
    let sut = EmailSentState.sut(username: "first")
    let result = sut.back()
    XCTAssertEqual((result as? EnterUsernameState)?.username, "first")
  }

}
