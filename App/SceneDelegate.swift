import UIKit
import Welcome
import Chat

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

//    let vc = Welcome.build(Welcome.Input(privacy: {
//      print("privacy")
//    }, done: {
//      print("done")
//    }))

    let vc = Chat.build()

    let window = UIWindow(windowScene: scene)
    window.rootViewController = vc
    window.makeKeyAndVisible()

    self.window = window
  }

}
