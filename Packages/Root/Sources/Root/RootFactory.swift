import UIKit

public protocol RootFactory {
  func build() -> UIViewController
}
