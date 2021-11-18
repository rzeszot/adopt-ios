import XCTest
import Mocky
import Unexpected
@testable import SignIn

final class ServiceTests: XCTestCase {

  var sut: Service!
  var mocky: Mocky!

  override func setUp() {
    sut = Service(session: .shared)
    mocky = Mocky.shared
    mocky.start()
  }

  override func tearDown() {
    sut = nil
    mocky.stop()
    mocky = nil
  }

  // MARK: -

  func test_request() {
    let request = sut.login(username: "USERNAME", password: "PASSWORD")

    XCTAssertEqual(request.url, "https://adopt.rzeszot.pro/sessions")
    XCTAssertEqual(request.httpMethod, "POST")
    XCTAssertNotNil(request.httpBody)
    XCTAssertEqual(request.httpBody, """
      {
        "login" : "USERNAME",
        "password" : "PASSWORD"
      }
      """.data(using: .utf8))
  }

  // MARK: -

  func test_success() async throws {
    mocky.post("/session") { env in
      env.load(from: "login-success.json", bundle: .module)
    }

    let response = try await sut.perform(username: "USERNAME", password: "PASSWORD")
    XCTAssertEqual(response.token, "ACCESS-TOKEN")
  }

  // MARK: -

  func test_failure_invalid_credentials() async throws {
    mocky.post("/session") { env in
      env.load(from: "login-failure-invalid-credentials.json", bundle: .module)
    }

    do {
      _ = try await sut.perform(username: "USERNAME", password: "PASSWORD")
      XCTFail()
    } catch {
      XCTAssertTrue(error is Service.InvalidCredentialsError)
    }
  }

  func test_failure_service_unavailable() async throws {
    mocky.post("/session") { env in
      env.load(from: "common-failure-service-unavailable.json", bundle: .module)
    }

    do {
      _ = try await sut.perform(username: "USERNAME", password: "PASSWORD")
      XCTFail()
    } catch {
      XCTAssertTrue(error is Service.ServiceUnavailable)
    }
  }

  func test_failure_upgrade_required() async throws {
    mocky.post("/session") { env in
      env.load(from: "common-failure-app-update-required.json", bundle: .module)
    }

    do {
      _ = try await sut.perform(username: "USERNAME", password: "PASSWORD")
      XCTFail()
    } catch {
      XCTAssertTrue(error is Service.UpgradeRequiredError)
    }
  }

  func test_failure_unexpected() async throws {
    mocky.post("/session") { env in
      env.load(from: "common-failure-unexpected.json", bundle: .module)
    }

    do {
      _ = try await sut.perform(username: "USERNAME", password: "PASSWORD")
      XCTFail()
    } catch {
      XCTAssertTrue(error is UnexpectedError)
    }
  }

}
