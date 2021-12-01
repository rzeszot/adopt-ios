import UIKit
import SwiftUI
import RequestPasswordReset

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

//    let vc = UIHostingController(rootView: RootView())
//    vc.view.backgroundColor = .systemYellow

    let vc = RequestPasswordReset.Builder.request(Input(username: "username", close: { reason in
      print("close \(reason)")
    }))

    let window = UIWindow(windowScene: scene)
    window.rootViewController = vc
    window.makeKeyAndVisible()

    self.window = window
  }
}
