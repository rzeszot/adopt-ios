import UIKit

public struct Builder {
  public static func welcome(_ input: Input) -> UIViewController {
    let vc = ViewController()
    vc.input = input
    return vc
  }
}

