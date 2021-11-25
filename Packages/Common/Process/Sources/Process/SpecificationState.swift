import Foundation

public protocol SpecificationState: State {
  func ignore(when state: State) -> Bool
  func transitionable(to state: State) -> Bool
}

public extension SpecificationState {
  func ignore(when state: State) -> Bool {
    false
  }

  func transitionable(to state: State) -> Bool {
    true
  }
}
