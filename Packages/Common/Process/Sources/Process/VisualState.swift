import UIKit

public protocol VisualState: State {
  func build(change: @escaping (State) -> Void) -> UIViewController
}
