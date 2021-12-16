import Foundation

public protocol Controllable: AnyObject {
  associatedtype C

  var controller: C { get }
}
