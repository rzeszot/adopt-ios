import UIKit

class TextField: UITextField {
  let padding: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }

  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }
}
