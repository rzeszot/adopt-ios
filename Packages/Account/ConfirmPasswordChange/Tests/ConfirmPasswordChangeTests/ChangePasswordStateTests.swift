import XCTest
@testable import ConfirmPasswordChange

final class ChangePasswordStateTests: XCTestCase {

  func test_when_close_then_state_is_CloseState_with_reason_cancel() {
    let sut = ChangePasswordState.sut()
    let result = sut.close()
    XCTAssertEqual((result as? CloseState)?.reason, .cancel)
  }

  func test_when_submit_succeeds_then_state_is_PasswordUpdateState() async {
    let sut = ChangePasswordState.sut(response: .success)
    let result = await sut.submit(password: "NEW-PASSWORD")
    XCTAssertTrue(result is PasswordUpdatedState)
  }

  func test_when_submit_fails_then_state_is_PasswordErrorState() async {
    let sut = ChangePasswordState.sut(response: .failure)
    let result = await sut.submit(password: "NEW-PASSWORD")
    XCTAssertTrue(result is PasswordErrorState)
  }

}

private extension ChangePasswordState {
  static func sut(username: String = "hello", code: String = "CODE", response: ClientMock.Behaviour = .fatal) -> ChangePasswordState {
    ChangePasswordState(username: username, code: code, client: ClientMock(behaviour: response))
  }
}
