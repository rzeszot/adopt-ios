//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
        let vc = Root.build(dependency: Root.Dependency(actor: .user(Session.User(credential: Session.Credential(email: "damian.rzeszot@gmail.com", token: "12345")))))

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.tintColor = #colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)

            window.rootViewController = vc
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}
