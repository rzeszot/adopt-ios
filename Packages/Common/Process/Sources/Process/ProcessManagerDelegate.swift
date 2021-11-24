import Foundation

public protocol ProcessManagerDelegate: AnyObject {
  func start(state: State)
  func change(from: State, to: State, using command: Command)
}
