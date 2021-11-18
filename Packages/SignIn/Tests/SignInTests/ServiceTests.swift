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

  func test_success() throws {
    let exp = expectation(description: "request")

    mocky.post("/session") { env in
      XCTAssertEqual(env.request.url?.absoluteString, "https://adopt.rzeszot.pro/sessions")
      let payload = try! env.request.json(type: Service.Request.self)
      XCTAssertEqual(payload?.login, "neo")
      XCTAssertEqual(payload?.password, "wheresthewhiterabbit")
    }

    mocky.post("/session") { env in
      env.load(from: "login-success.json", bundle: .module)
    }

    sut.login(.init(login: "neo", password: "wheresthewhiterabbit")) { result in
      exp.fulfill()
      guard case .success(let success) = result else { XCTFail(); return }

      XCTAssertEqual(success.token, "ACCESS-TOKEN")
    }

    wait(for: [exp], timeout: 0.5)
  }

  // MARK: -

  func test_failure_invalid_credentials() throws {
    let exp = expectation(description: "request")

    mocky.post("/session") { env in
      env.load(from: "login-failure-invalid-credentials.json", bundle: .module)
    }

    sut.login(.init(login: "neo", password: "wheresthewhiterabbit")) { result in
      exp.fulfill()
      guard case .failure(let error) = result else { XCTFail(); return }

      XCTAssertTrue(error is Service.InvalidCredentialsError)
    }

    wait(for: [exp], timeout: 0.5)
  }

  func test_failure_service_unavailable() throws {
    let exp = expectation(description: "request")

    mocky.post("/session") { env in
      env.load(from: "common-failure-service-unavailable.json", bundle: .module)
    }

    sut.login(.init(login: "neo", password: "wheresthewhiterabbit")) { result in
      exp.fulfill()
      guard case .failure(let error) = result else { XCTFail(); return }

      XCTAssertTrue(error is Service.ServiceUnavailable)
    }

    wait(for: [exp], timeout: 0.5)
  }

  func test_failure_update_required() throws {
    let exp = expectation(description: "request")

    mocky.post("/session") { env in
      env.load(from: "common-failure-app-update-required.json", bundle: .module)
    }

    sut.login(.init(login: "neo", password: "wheresthewhiterabbit")) { result in
      exp.fulfill()
      guard case .failure(let error) = result else { XCTFail(); return }

      XCTAssertTrue(error is Service.UpgradeRequiredError)
    }

    wait(for: [exp], timeout: 0.5)
  }

  func test_failure_unexpected() throws {
    let exp = expectation(description: "request")

    mocky.post("/session") { env in
      env.load(from: "common-failure-unexpected.json", bundle: .module)
    }

    sut.login(.init(login: "neo", password: "wheresthewhiterabbit")) { result in
      exp.fulfill()
      guard case .failure(let error) = result else { XCTFail(); return }

      XCTAssertTrue(error is UnexpectedError)
    }

    wait(for: [exp], timeout: 0.5)
  }
}
