import UIKit

public protocol Creator {
  associatedtype S: State
  func build(state: S) -> UIViewController
}
