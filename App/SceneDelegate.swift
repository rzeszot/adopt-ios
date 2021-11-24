import UIKit
import RequestPasswordReset
import ConfirmPasswordChange

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    let vc = RequestPasswordReset.Builder.request(Input(username: "contact@rzeszot.pro", close: { reason in
      print("remind closed with reason: \(reason)")
    }))

//    let vc = ConfirmPasswordChange.Builder.confirm(Input(username: "contact@rzeszot.pro", code: "authcode", close: { reason in
//      print("remind closed with reason: \(reason)")
//    }))

    let window = UIWindow(windowScene: scene)
    window.rootViewController = vc
    window.makeKeyAndVisible()

    self.window = window
  }

}
