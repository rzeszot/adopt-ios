import XCTest
import Unexpected

final class UnexpectedErrorTests: XCTestCase {
  func test_result_unexpected_error() {
    let result: Result<Void, Error> = .unexpected

    XCTAssertThrowsError(try result.get()) { error in
      XCTAssertTrue(error is UnexpectedError)
    }
  }
}
