import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    let vc = UIViewController()
    vc.view.backgroundColor = .systemYellow

    let window = UIWindow(windowScene: scene)
    window.rootViewController = vc
    window.makeKeyAndVisible()

    self.window = window
  }
}
