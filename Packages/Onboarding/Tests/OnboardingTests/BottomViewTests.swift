import XCTest
import XCSnapshots
@testable import Onboarding

final class BottomViewTests: XCTestCase {

  private var sut: BottomView!

  override func setUp() {
    sut = BottomView()
    sut.frame = CGRect(x: 0, y: 0, width: 390, height: 150)
    sut.didMoveToSuperview()
    sut.layoutIfNeeded()
  }

  override func tearDown() {
    sut = nil
  }

  // MARK: -

  func test_view() {
    XCAssertSnapshot(matching: sut, as: .image)
  }

}
