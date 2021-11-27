import XCTest
@testable import ConfirmPasswordChange

final class SubmitErrorStateTests: XCTestCase {

  func test_when_ok_then_state_is_ChangePasswordState() {
    let sut = SubmitErrorState.sut()
    let result = sut.ok()
    XCTAssertTrue(result is ChangePasswordState)
  }

}

private extension SubmitErrorState {
  static func sut(username: String = "hello", code: String = "CODE", response: ClientMock.Behaviour = .failure) -> SubmitErrorState {
    SubmitErrorState(username: username, code: code, client: ClientMock(behaviour: response))
  }
}
