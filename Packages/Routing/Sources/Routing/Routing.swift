import Foundation

public protocol Routing: AnyObject {
  var children: [Routing] { get }

  func attach(_ child: Routing)
  func detach(_ child: Routing)
}
