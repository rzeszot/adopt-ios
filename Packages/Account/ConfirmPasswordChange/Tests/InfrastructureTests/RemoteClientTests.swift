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

  func test_response_success() async throws {
    mocky.post("/account/forgot-password/confirm") { env in
      env.request.validate(from: "confirm.request", subdirectory: "Requests", bundle: .module)
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
      env.request.validate(from: "confirm.request", subdirectory: "Requests", bundle: .module)
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

// swiftlint:disable force_try
extension Request {
  func validate(from file: String, subdirectory: String, bundle: Bundle) {
    let url = bundle.url(forResource: file, withExtension: nil, subdirectory: subdirectory)!

    let content = try! String(contentsOf: url)
    let chunks = content.components(separatedBy: "\n---\n")

    for option in chunks[0].split(separator: "\n") {
      let parts = option.components(separatedBy: ": ")
      let key = parts[0]
      let value = parts[1]

      switch key {
      case "method":
        XCTAssertEqual(method, value)
      case "url":
        XCTAssertEqual(self.url?.absoluteString, value)
      default:
        fatalError("`\(key)` is not supported")
      }
    }

    for header in chunks[1].split(separator: "\n") {
      let parts = header.components(separatedBy: ": ")
      let key = parts[0]
      let value = parts[1]
      let sut = headers[key]

      XCTAssertEqual(sut, value)
    }

    let data = chunks[2].data(using: .utf8)!

    XCTAssertEqual(body, data.prefix(data.count-1))
  }
}
