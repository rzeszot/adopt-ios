import XCTest
import Mocky
import Networking
import Unexpected
@testable import RequestPasswordReset

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
    let request = try sut.build(username: "user@example.org")

    XCTAssertEqual(request.url, "https://adopt.rzeszot.pro/account/forgot-password/request")
    XCTAssertEqual(request.httpMethod, "POST")
    XCTAssertNotNil(request.httpBody)
    XCTAssertEqual(request.httpBody, """
      {
        "username" : "user@example.org"
      }
      """.data(using: .utf8))
  }

  func test_success() async throws {
    mocky.post("/account/forgot-password/request") { env in
      XCTAssertEqual(env.request.body, Fixture.request.data)
      env.load(from: "reset-success.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      let _: RemoteClient.SuccessResponse = try await sut.request(username: "user@example.org")
    } catch {
      XCTFail("XCTAssertNoThrowAwait")
    }
  }

  func test_failure() async throws {
    mocky.post("/account/forgot-password/request") { env in
      XCTAssertEqual(env.request.body, Fixture.request.data)
      env.load(from: "reset-failure.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      let _: RemoteClient.SuccessResponse = try await sut.request(username: "user@example.org")
    } catch {
      XCTAssertTrue(error is RemoteClient.FailureResponse)
    }
  }

}

extension Fixture {
  static var request: Fixture = """
    {
      "username" : "user@example.org"
    }
    """
}
