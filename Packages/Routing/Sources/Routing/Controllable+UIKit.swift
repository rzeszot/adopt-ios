import UIKit

extension UIViewController: Controllable {
  public var controller: UIViewController {
    self
  }
}
//
//public extension Controllable where Self: UIViewController {
//  var controller: UIViewController {
//    self
//  }
//}
