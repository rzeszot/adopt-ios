import Foundation

protocol Routing {
  func dispatch(_ command: RoutingCommand)
}

extension Routing {
  func dispatch(_ command: RoutingCommand) {

  }
}

protocol RoutingCommand {

}
