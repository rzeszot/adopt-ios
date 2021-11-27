import XCTest
@testable import ConfirmPasswordChange

final class PasswordErrorStateTests: XCTestCase {

  func test_when_ok_then_state_is_ChangePasswordState() {
    let sut = PasswordErrorState.sut()
    let result = sut.ok()
    XCTAssertTrue(result is ChangePasswordState)
  }

}

private extension PasswordErrorState {
  static func sut(username: String = "hello", code: String = "CODE", response: ClientMock.Behaviour = .failure) -> PasswordErrorState {
    PasswordErrorState(username: username, code: code, client: ClientMock(behaviour: response))
  }
}
