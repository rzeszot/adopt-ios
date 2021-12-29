import XCTest
import XCSnapshots
@testable import Login

final class LoginViewControllerTests: XCTestCase {

  private var sut: LoginViewController!

  override func setUp() {
    sut = LoginViewController()
  }

  override func tearDown() {
    sut = nil
  }

  // MARK: -

  func test_view() {
    XCAssertSnapshot(matching: sut, as: .image)
  }

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
