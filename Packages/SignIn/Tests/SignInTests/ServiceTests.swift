import XCTest
import Mocky
@testable import SignIn

final class ServiceTests: XCTestCase {

  var sut: Service!

  override func setUp() {
    sut = Service(session: .shared)
    Mocky.shared.start()
  }

  override func tearDown() {
    Mocky.shared.stop()
    sut = nil
  }

  // MARK: -

  func test_success() throws {
    let exp = expectation(description: "request")

    Mocky.shared.post("/session") { env in
      XCTAssertEqual(env.request.url?.absoluteString, "https://adopt.rzeszot.pro/sessions")
      let payload = try! env.request.json(type: Service.Request.self)
      XCTAssertEqual(payload?.login, "neo")
      XCTAssertEqual(payload?.password, "wheresthewhiterabbit")

      env.response.status = 201
      try! env.response.body(json: Service.Response(token: "authentication-token"))
    }

    sut.login(.init(login: "neo", password: "wheresthewhiterabbit")) { result in
      exp.fulfill()
      guard case .success(let success) = result else { XCTFail(); return }

      XCTAssertEqual(success.token, "authentication-token")
    }

    wait(for: [exp], timeout: 0.5)
  }

}
