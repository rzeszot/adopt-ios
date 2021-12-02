import UIKit

extension UIViewController: Routable {
  func attach(_ child: UIViewController) {
    precondition(child.parent == nil)
    print("\(self) attach \(child)")

    addChild(child)
  }

  func detach(_ child: UIViewController) {
    precondition(child.parent == self)
    print("\(self) detach \(child)")

    child.removeFromParent()
  }
}
