import Foundation

protocol Gate {
  func dispatch(_ command: Command)
}
