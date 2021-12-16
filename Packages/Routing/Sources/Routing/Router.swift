import Foundation

public class Router: Routing {

  public private(set) var children: [Routing] = []

  public func attach(_ child: Routing) {
    children.append(child)
  }

  public func detach(_ child: Routing) {
    children.removeAll { $0 === child }
  }
}
