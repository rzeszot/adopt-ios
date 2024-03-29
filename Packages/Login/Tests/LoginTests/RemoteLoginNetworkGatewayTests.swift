import XCTest
import XCSnapshots
import Mocky
import Unexpected
@testable import Login

final class RemoteLoginNetworkGatewayTests: XCTestCase {

  var sut: RemoteLoginNetworkGateway!
  var mocky: Mocky!

  override func setUp() {
    sut = RemoteLoginNetworkGateway(url: "https://adopt.com/api/login", session: .shared)
    mocky = Mocky.shared
    mocky.start()
  }

  override func tearDown() {
    sut = nil
    mocky.stop()
    mocky = nil
  }

  // MARK: -

  func test_build_request() throws {
    let request = try sut.build(LoginRequest(username: "USERNAME", password: "PASSWORD"))
    XCAssertSnapshot(matching: request, as: .http2)
  }

  // MARK: -

  func test_success() async throws {
    mocky.use("login-success.json")

    let response = try await sut.perform(LoginRequest(username: "USERNAME", password: "PASSWORD"))
    XCTAssertEqual(response.token, "ACCESS-TOKEN")
  }

  // MARK: -

  func test_failure_invalid_credentials() async throws {
    mocky.use("login-failure-invalid-credentials.json")

    do {
      _ = try await sut.perform(LoginRequest(username: "USERNAME", password: "PASSWORD"))
      XCTFail("XCTAssertThrowAwait")
    } catch {
      print("xxx \(error)")
      XCTAssertTrue(error is InvalidCredentialsResponse)
    }
  }

  func test_failure_unexpected() async throws {
    mocky.use("common-failure-unexpected.json")

    do {
      _ = try await sut.perform(LoginRequest(username: "USERNAME", password: "PASSWORD"))
      XCTFail("XCTAssertThrowAwait")
    } catch {
      XCTAssertTrue(error is UnexpectedError)
    }
  }

}

private extension Mocky {
  func use(_ file: String) {
    post("/api/login") { env in
      env.load(from: file, subdirectory: "Mocky", bundle: .module)
    }
  }
}
