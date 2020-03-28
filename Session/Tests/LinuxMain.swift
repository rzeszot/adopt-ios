import XCTest
import SessionTests

var tests = [XCTestCaseEntry]()

tests += LoginServiceTests.allTests()

XCTMain(tests)
