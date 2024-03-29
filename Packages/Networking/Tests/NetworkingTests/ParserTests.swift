import XCTest
@testable import Networking
import Unexpected

final class ParserTests: XCTestCase {
  var sut: Parser!

  override func setUp() {
    sut = Parser(types: [
      SuccessResponse.self,
      AcceptedResponse.self,
      BadRequestResponse.self
    ])
  }

  override func tearDown() {
    sut = nil
  }

  // MARK: -

  func test_parse_success() throws {
    let object = try sut.parse(response: .status(200), data: Fixture.success.data)
    XCTAssertEqual((object as? SuccessResponse)?.number, 42)
  }

  func test_parse_unexpected_code() throws {
    do {
      _ = try sut.parse(response: .status(418), data: Fixture.success.data)
      XCTFail("XCTAssertThrowAwait")
    } catch {
      XCTAssertTrue(error is UnexpectedError)
    }
  }

  func test_parse_decoding_error() throws {
    do {
      _ = try sut.parse(response: .status(200), data: Fixture.shrug.data)
      XCTFail("XCTAssertThrowAwait")
    } catch {
      XCTAssertTrue(error is DecodingError)
    }
  }

  // MARK: -

  func test_decode() throws {
    let object = try sut.decode(data: Fixture.success.data, type: SuccessResponse.self)
    XCTAssertEqual((object as? SuccessResponse)?.number, 42)
  }

  // MARK: -

  func test_type_success() {
    let type = sut.type(for: .status(200))
    XCTAssertNotNil(type)
  }

  func test_type_accepted() {
    let type = sut.type(for: .status(202))
    XCTAssertNotNil(type)
  }

  func test_type_bad_request() {
    let type = sut.type(for: .status(400))
    XCTAssertNotNil(type)
  }

  func test_type_unexpected() {
    let type = sut.type(for: .status(418))
    XCTAssertNil(type)
  }

}

extension Fixture {
  static let success: Fixture = """
    {
      "number": 42
    }
    """
  static let shrug: Fixture = """
    ¯\\_(ツ)_/¯
  """
}
