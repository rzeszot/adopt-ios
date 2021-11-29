import UIKit

public struct Builder {
  public static func signin(_ input: Input) -> UIViewController {
    let vc = SignInViewController()
    vc.output = SignInOutput(
      remind: input.remind ?? {},
      close: {
        print("close")
      })
    return vc
  }
}
