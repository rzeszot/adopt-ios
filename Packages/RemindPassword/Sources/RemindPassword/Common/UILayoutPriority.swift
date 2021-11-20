import UIKit

extension UILayoutPriority: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self.init(rawValue: Float(value))
  }
}
