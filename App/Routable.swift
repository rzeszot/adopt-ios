import Foundation

protocol Routable {
  associatedtype R: Routable

  var children: [R] { get }
  var parent: R? { get }

  func attach(_ child: R)
  func detach(_ child: R)
}

extension Routable {
  func parent<T>(of type: T.Type) -> T? {
    parent as? T ?? parent?.parent(of: type)
  }
}
