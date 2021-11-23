import XCTest
import Mocky
import Networking
import Unexpected
@testable import ConfirmPasswordChange

final class ConfirmPasswordChangeServiceTests: XCTestCase {

  var sut: ConfirmPasswordChangeService!
  var mocky: Mocky!

  override func setUp() {
    sut = ConfirmPasswordChangeService(session: .shared)
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
    XCTAssertNotNil(request.httpBody)
    XCTAssertEqual(request.httpBody, """
      {
        "code" : "CODE",
        "password" : "NEW-PASSWORD",
        "username" : "USERNAME"
      }
      """.data(using: .utf8))
  }

  func test_success() async throws {
    mocky.post("/account/forgot-password/confirm") { env in
      env.load(from: "confirm-success.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      _ = try await sut.request(username: "USERNAME", password: "NEW-PASSWORD", code: "TOKEN")
    } catch {
      XCTFail("XCTAssertNoThrowAwait")
    }
  }

  func test_failure() async throws {
    mocky.post("/account/forgot-password/confirm") { env in
      env.load(from: "confirm-failure.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      _ = try await sut.request(username: "USERNAME", password: "NEW-PASSWORD", code: "CODE")
    } catch {
      XCTAssertTrue(error is ConfirmPasswordChangeService.FailureResponse)
    }
  }

}
