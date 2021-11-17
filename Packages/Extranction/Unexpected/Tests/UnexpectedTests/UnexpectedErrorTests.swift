import XCTest
import Unexpected

final class UnexpectedErrorTests: XCTestCase {
  func test_result_unexpected_error() {
    let result: Result<Void, Error> = .unexpected

    switch result {
    case .success:
      XCTFail()
    case .failure(let error):
      XCTAssertTrue(error is UnexpectedError)
    }
  }
}
