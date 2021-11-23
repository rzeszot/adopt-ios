import UIKit

public struct Builder {
  public static func build(_ input: Input) -> UIViewController {
    let vc = SignInViewController()
    return vc
  }
}
