import XCTest
import Fixture

final class FixtureTests: XCTestCase {

  var sut: Fixture!

  override func setUp() {
    sut = .hello
  }

  // MARK: -

  func test_fixture_returnsString() {
    // when
    let result = sut.string

    // then
    XCTAssertEqual(result, """
      {
        "hello": "world"
      }
      """)
  }

  func test_fixture_returnsData() {
    // when
    let result = sut.data

    // then
    XCTAssertEqual(result, Data([123, 10, 32, 32, 34, 104, 101, 108, 108, 111, 34, 58, 32, 34, 119, 111, 114, 108, 100, 34, 10, 125]))
  }

}

private extension Fixture {
  static var hello: Fixture = """
    {
      "hello": "world"
    }
    """
}
