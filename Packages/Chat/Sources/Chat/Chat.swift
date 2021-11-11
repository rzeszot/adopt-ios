import UIKit

public struct Chat {
  public static func build() -> UIViewController {
    let vc = ConversationViewController()

    return vc
  }

  static func conversation() -> UIViewController {
    let root = ConversationViewController()

    return root
  }
}
