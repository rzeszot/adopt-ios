import UIKit

public struct Builder {
  public static func build() -> UIViewController {
    let vc = EnterUsernameViewController()
    return vc
  }
}
