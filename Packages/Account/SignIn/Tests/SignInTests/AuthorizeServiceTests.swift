import XCTest
import Mocky
import Networking
import Unexpected
@testable import SignIn

final class AuthorizeServiceTests: XCTestCase {

  var sut: AuthorizeService!
  var mocky: Mocky!

  override func setUp() {
    sut = AuthorizeService(session: .shared)
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
    let request = try sut.build(username: "USERNAME", password: "PASSWORD")

    XCTAssertEqual(request.url, "https://adopt.rzeszot.pro/auth/token")
    XCTAssertEqual(request.httpMethod, "POST")
    XCTAssertNotNil(request.httpBody)
    XCTAssertEqual(request.httpBody, """
      {
        "grant_type" : "password",
        "password" : "PASSWORD",
        "username" : "USERNAME"
      }
      """.data(using: .utf8))
  }

  // MARK: -

  func test_success() async throws {
    mocky.post("/auth/token") { env in
      env.load(from: "login-success.json", subdirectory: "Responses", bundle: .module)
    }

    let response = try await sut.request(username: "USERNAME", password: "PASSWORD")
    XCTAssertEqual(response.token, "ACCESS-TOKEN")
  }

  // MARK: -

  func test_failure_invalid_credentials() async throws {
    mocky.post("/auth/token") { env in
      env.load(from: "login-failure-invalid-credentials.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      _ = try await sut.request(username: "USERNAME", password: "PASSWORD")
      XCTFail("XCTAssertThrowAwait")
    } catch {
      XCTAssertTrue(error is AuthorizeService.InvalidClientResponse)
    }
  }

  func test_failure_upgrade_required() async throws {
    mocky.post("/auth/token") { env in
      env.load(from: "common-failure-app-update-required.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      _ = try await sut.request(username: "USERNAME", password: "PASSWORD")
      XCTFail("did not throw an error")
    } catch let error as UpgradeRequiredResponse {
      XCTAssertEqual(error.url, "https://adopt.rzeszot.pro/r/upgrage/2.5.1")
      XCTAssertEqual(error.version, "2.5.1")
    } catch {
      XCTAssertTrue(error is UpgradeRequiredResponse, "(\(error)) is not instance of (\(UpgradeRequiredResponse.self))")
    }
  }

  func test_failure_unexpected() async throws {
    mocky.post("/auth/token") { env in
      env.load(from: "common-failure-unexpected.json", subdirectory: "Responses", bundle: .module)
    }

    do {
      _ = try await sut.request(username: "USERNAME", password: "PASSWORD")
      XCTFail("XCTAssertThrowAwait")
    } catch {
      XCTAssertTrue(error is UnexpectedError)
    }
  }

}
