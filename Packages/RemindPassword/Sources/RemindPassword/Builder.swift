import UIKit

public struct Builder {
  public static func reset(_ input: Reset) -> UIViewController {
    let vc = EnterUsernameViewController()
    vc.viewModel = EnterUsernameViewModel(input)
    return vc
  }

  public static func confirm(_ input: Confirm) -> UIViewController {
    let vc = ChangePasswordViewController()
    return vc
  }
}
