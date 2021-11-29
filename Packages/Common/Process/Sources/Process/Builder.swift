import Foundation

public protocol AnimatableState: State {
  func animatable(when destination: State) -> Bool
}
