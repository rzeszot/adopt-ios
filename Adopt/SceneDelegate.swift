//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
        let session = Session()
        let vc = Root.build(session: session)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = vc
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}

private extension Root {
    static func build(session: Session) -> UIViewController {
        build(dependency: Dependency(session: session))
    }
}
