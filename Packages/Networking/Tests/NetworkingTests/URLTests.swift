import XCTest
@testable import Networking

final class URLTests: XCTestCase {

  // MARK: - ExpressibleByStringLiteral

  func test_url_expressible_by_string_literal() {
    let url: URL = "https://example.org/expressible/string"

    XCTAssertEqual(url.absoluteString, "https://example.org/expressible/string")
  }

  // MARK: -

  func test_url_equal_to_string() {
    let url = URL(string: "https://example.org/path")!

    XCTAssertEqual(url, "https://example.org/path")
    XCTAssertNotEqual(url, "https://example.org/other")
  }
}
