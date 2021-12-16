import XCTest
import Mocky
import Unexpected
@testable import Login

final class LoginInteractorTests: XCTestCase {

  private var output: LoginUseCaseOutputMock!
  private var gateway: LoginNetworkGatewayMock!

  var sut: LoginInteractor!

  override func setUp() {
    output = LoginUseCaseOutputMock()
    gateway = LoginNetworkGatewayMock()

    sut = LoginInteractor(output: output, gateway: gateway)
  }

  override func tearDown() {
    output = nil
    gateway = nil
    sut = nil
  }

  // MARK: -

  func test_success() async {
    gateway.result = .success(LoginSuccessResponse(token: "TOKEN"))
    await sut.login(username: "USERNAME", password: "PASSWORD")
    XCTAssertEqual(output.result, .success(LoginSuccess(token: "TOKEN")))
  }

  func test_failure_invalid_credentials() async {
    gateway.result = .failure(InvalidCredentialsResponse())
    await sut.login(username: "USERNAME", password: "PASSWORD")
    XCTAssertEqual(output.result, .failure(.credentials))
  }

  func test_failure_unexpected() async {
    gateway.result = .failure(UnexpectedError())
    await sut.login(username: "USERNAME", password: "PASSWORD")
    XCTAssertEqual(output.result, .failure(.other))
  }

}

private class LoginUseCaseOutputMock: LoginUseCaseOutput {
  var result: Result<LoginSuccess, LoginFailure>?

  func done(success: LoginSuccess) {
    result = .success(success)
  }

  func show(failure: LoginFailure) {
    result = .failure(failure)
  }
}

private class LoginNetworkGatewayMock: LoginNetworkGateway {
  var result: Result<LoginSuccessResponse, Error>!

  func perform(_ request: LoginRequest) async throws -> LoginSuccessResponse {
    try result.get()
  }
}
