import XCTest
import XCSnapshots
@testable import Onboarding

final class StepViewControllerTests: XCTestCase {

  private var sut: StepViewController!

  override func setUp() {
    sut = StepViewController()
    sut.loadViewIfNeeded()
    sut.view.frame = CGRect(x: 0, y: 0, width: 390, height: 390)
  }

  override func tearDown() {
    sut = nil
  }

  // MARK: -

  func test_view() {
    sut.viewModel = .lorem
    XCAssertSnapshot(matching: sut.view, as: .image)
  }

}

extension StepViewModel {
  static var lorem: StepViewModel = StepViewModel(
    title: "Excepteur sint occaecat",
    subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  )
}
