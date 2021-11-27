import XCTest
@testable import ConfirmPasswordChange

final class PasswordUpdatedStateTests: XCTestCase {

  func test_when_dismiss_then_state_is_CloseState_with_reason_dismiss() {
    let sut = PasswordUpdatedState.sut()
    let result = sut.dismiss()
    XCTAssertEqual((result as? CloseState)?.reason, .dismiss)
  }

  func test_when_done_then_state_is_CloseState_with_reason_authorize() {
    let sut = PasswordUpdatedState.sut()
    let result = sut.dismiss()
    XCTAssertEqual((result as? CloseState)?.reason, .dismiss)
  }

}

private extension PasswordUpdatedState {
  static func sut(username: String = "hello") -> PasswordUpdatedState {
    PasswordUpdatedState(username: username)
  }
}
