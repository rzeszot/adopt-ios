import XCTest
import Mocky
import Networking
import Unexpected
@testable import RemindPassword

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
    let request = try sut.request(password: "NEW-PASSWORD", token: "TOKEN")

    XCTAssertEqual(request.url, "https://adopt.rzeszot.pro/sessions/set-password")
    XCTAssertEqual(request.httpMethod, "POST")
    XCTAssertNotNil(request.httpBody)
    XCTAssertEqual(request.httpBody, """
      {
        "password" : "NEW-PASSWORD",
        "token" : "TOKEN"
      }
      """.data(using: .utf8))
  }

  func test_success() async throws {
    mocky.post("/sessions/set-password") { env in
      env.load(from: "confirm-success.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      _ = try await sut.perform(password: "NEW-PASSWORD", token: "TOKEN")
    } catch {
      XCTFail()
    }
  }

  func test_failure() async throws {
    mocky.post("/sessions/set-password") { env in
      env.load(from: "confirm-failure.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      _ = try await sut.perform(password: "NEW-PASSWORD", token: "TOKEN")
    } catch {
      XCTAssertTrue(error is ConfirmPasswordChangeService.FailureResponse)
    }
  }

}
