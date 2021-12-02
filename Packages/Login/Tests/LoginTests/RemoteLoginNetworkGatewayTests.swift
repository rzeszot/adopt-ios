import XCTest
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

    XCTAssertEqual(request.url, "https://adopt.com/api/login")
    XCTAssertEqual(request.httpMethod, "POST")
    XCTAssertEqual(request.value(forHTTPHeaderField: "content-type"), "application/json")
    XCTAssertEqual(request.httpBody, """
      {
        "password" : "PASSWORD",
        "username" : "USERNAME"
      }
      """.data(using: .utf8))
  }

  // MARK: -

  func test_success() async throws {
    mocky.post("/api/login") { env in
      env.load(from: "login-success.json", subdirectory: "Mocky", bundle: .module)
    }

    let response = try await sut.perform(LoginRequest(username: "USERNAME", password: "PASSWORD"))
    XCTAssertEqual(response.token, "ACCESS-TOKEN")
  }

  // MARK: -

  func test_failure_invalid_credentials() async throws {
    mocky.post("/api/login") { env in
      env.load(from: "login-failure-invalid-credentials.json", subdirectory: "Mocky", bundle: .module)
    }

    do {
      _ = try await sut.perform(LoginRequest(username: "USERNAME", password: "PASSWORD"))
      XCTFail("XCTAssertThrowAwait")
    } catch {
      print("xxx \(error)")
      XCTAssertTrue(error is InvalidCredentialsResponse)
    }
  }

  func test_failure_unexpected() async throws {
    mocky.post("/api/login") { env in
      env.load(from: "common-failure-unexpected.json", subdirectory: "Mocky", bundle: .module)
    }

    do {
      _ = try await sut.perform(LoginRequest(username: "USERNAME", password: "PASSWORD"))
      XCTFail("XCTAssertThrowAwait")
    } catch {
      XCTAssertTrue(error is UnexpectedError)
    }
  }

}
