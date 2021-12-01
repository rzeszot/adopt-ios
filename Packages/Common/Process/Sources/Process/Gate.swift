import Foundation

public protocol Gate {
  associatedtype C: Command

  func dispatch(_ command: C)
}
