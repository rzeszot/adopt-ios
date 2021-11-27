import UIKit
import Process

protocol Creator {
  associatedtype Source: State
  func build(state: Source, change: @escaping (State) -> Void) -> UIViewController
}
