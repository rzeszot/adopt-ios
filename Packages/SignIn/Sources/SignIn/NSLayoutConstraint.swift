import UIKit

extension NSLayoutConstraint {
  @discardableResult
  func priority(_ priority: UILayoutPriority) -> Self {
    self.priority = priority
    return self
  }
}
