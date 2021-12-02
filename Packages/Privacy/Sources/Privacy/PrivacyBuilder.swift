import UIKit

public struct PrivacyBuilder {
  let dismiss: () -> Void

  public init(dismiss: @escaping () -> Void) {
    self.dismiss = dismiss
  }

  public func build() -> UIViewController {
    let vc = PrivacyViewController()
    vc.dismiss = dismiss
    let nav = UINavigationController(rootViewController: vc)
    return nav
  }

}
