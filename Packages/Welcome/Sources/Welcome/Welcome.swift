import UIKit

public struct Welcome {
  public struct Input {
    let privacy: () -> Void
    let done: () -> Void

    public init(privacy: @escaping () -> Void, done: @escaping () -> Void) {
      self.privacy = privacy
      self.done = done
    }
  }

  public static func build(_ input: Input) -> UIViewController {
    let vc = ViewController()
    vc.input = input
    return vc
  }
}
