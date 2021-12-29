import XCTest
import XCSnapshots
@testable import Onboarding

final class ContainerViewControllerTests: XCTestCase {

  private var sut: ContainerViewController!

  override func setUp() {
    sut = ContainerViewController()
    sut.loadViewIfNeeded()
    sut.additionalSafeAreaInsets = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
    sut.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
    sut.view.layoutIfNeeded()
    sut.viewDidLayoutSubviews()
  }

  override func tearDown() {
    sut = nil
  }

  // MARK: -

  func test_snapshot_ltr() {
    sut.viewModel = .lorem
    XCAssertSnapshot(matching: sut, as: .image)
  }

  func test_snapshot_rtl() {
    sut.viewModel = .lorem
    XCAssertSnapshot(matching: sut, as: .image)
  }

  func test_snapshot_lightmode() {
    sut.viewModel = .lorem
    XCAssertSnapshot(matching: sut, as: .image)
  }

  func test_snapshot_darkmode() {
    sut.viewModel = .lorem
    XCAssertSnapshot(matching: sut, as: .image)
  }

}

extension ContainerViewModel {
  static var lorem = ContainerViewModel(steps: [
    StepViewModel(
      title: "Lorem ipsum dolor sit amet",
      subtitle: "Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco."
    ),
    StepViewModel(
      title: "Laboris nisi",
      subtitle: "Ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit."
    ),
    StepViewModel(
      title: "In voluptate velit esse cillum",
      subtitle: "Dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )
  ])
}

private extension Snapshotting where Value == UIViewController, Format == UIImage {
  static var image: Snapshotting {
    .init(diffing: .image(precision: 1, scale: 3), persisting: .image(scale: 3), transformer: Transforming<UIViewController, UIImage>(transform: { vc in

      let traits = UITraitCollection(traitsFrom: [
        .init(displayGamut: .P3),
        .init(displayScale: 3),
        .init(userInterfaceIdiom: .phone),
        .init(horizontalSizeClass: .compact),
        .init(verticalSizeClass: .regular),
        .init(userInterfaceStyle: .light),
        .init(layoutDirection: .leftToRight)
      ])

      let size = CGSize(width: 390, height: 844)
      let safeAreaInsets = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)

      let window = ScreenshotWindow(size: size, safeAreaInsets: safeAreaInsets, traitCollection: traits)
      window.backgroundColor = .systemRed
      window.rootViewController = vc
      window.makeKeyAndVisible()

      window.layoutIfNeeded()

      return snapshot(window, traits: traits)
    }))
  }

}

private func snapshot(_ view: UIView, traits: UITraitCollection) -> UIImage {
  let format = UIGraphicsImageRendererFormat(for: traits)
  let renderer = UIGraphicsImageRenderer(bounds: view.bounds, format: format)

  return renderer.image { ctx in
    view.layer.render(in: ctx.cgContext)
  }
}

class ScreenshotWindow: UIWindow {
  private let overrideSafeAreaInsets: UIEdgeInsets
  private let overrideTraitCollection: UITraitCollection

  init(size: CGSize, safeAreaInsets: UIEdgeInsets, traitCollection: UITraitCollection) {
    self.overrideSafeAreaInsets = safeAreaInsets
    self.overrideTraitCollection = traitCollection
    super.init(frame: CGRect(origin: .zero, size: size))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override var safeAreaInsets: UIEdgeInsets {
    overrideSafeAreaInsets
  }

  override var traitCollection: UITraitCollection {
    overrideTraitCollection
  }

}
