import XCTest
import Mocky
import Networking
import Fixture
@testable import ConfirmPasswordChange

final class RemoteClientTests: XCTestCase {

  var sut: RemoteClient!
  var mocky: Mocky!

  override func setUp() {
    sut = RemoteClient(session: .shared)
    mocky = Mocky.shared
    mocky.start()
  }

  override func tearDown() {
    sut = nil
    mocky.stop()
    mocky = nil
  }

  // MARK: -

  func test_request() throws {
    let request = try sut.build(username: "USERNAME", password: "NEW-PASSWORD", code: "CODE")

    XCTAssertEqual(request.url, "https://adopt.rzeszot.pro/account/forgot-password/confirm")
    XCTAssertEqual(request.httpMethod, "POST")
    XCTAssertEqual(request.httpBody, Fixture.request.data)
  }

  func test_response_success() async throws {
    mocky.post("/account/forgot-password/confirm") { env in
      XCTAssertEqual(env.request.body, Fixture.request.data)
      env.load(from: "confirm-success.response", subdirectory: "Responses", bundle: .module)
    }

    do {
      let _: RemoteClient.SuccessResponse = try await sut.request(username: "USERNAME", password: "NEW-PASSWORD", code: "CODE")
    } catch {
      XCTFail("XCTAssertNoThrowAwait")
    }
  }

  func test_response_failure() async throws {
    mocky.post("/account/forgot-password/confirm") { env in
      XCTAssertEqual(env.request.body, Fixture.request.data)
      env.load(from: "confirm-failure.response", subdirectory: "Responses", bundle: .module)
    }

    do {
      let _: RemoteClient.SuccessResponse = try await sut.request(username: "USERNAME", password: "NEW-PASSWORD", code: "CODE")
      XCTFail("XCTAssertThrowAwait")
    } catch {
      XCTAssertTrue(error is RemoteClient.FailureResponse)
    }
  }

}

private extension Fixture {
  static var request: Fixture = """
    {
      "code" : "CODE",
      "password" : "NEW-PASSWORD",
      "username" : "USERNAME"
    }
    """
}
