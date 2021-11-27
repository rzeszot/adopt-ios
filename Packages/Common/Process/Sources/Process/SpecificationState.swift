import Foundation

public protocol SpecificationState: State {
  func ignore(when destination: State) -> Bool
  func transitionable(to destination: State) -> Bool
}

public extension SpecificationState {
  func ignore(when destination: State) -> Bool {
    false
  }

  func transitionable(to destination: State) -> Bool {
    true
  }
}
