import Foundation

public protocol Gate {
  func transition(to state: State)
}
