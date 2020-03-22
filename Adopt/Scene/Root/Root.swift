//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Root {
    struct Dependency {
        let session: Session
    }
}

extension Root {
    static func build(dependency: Dependency) -> UIViewController {
        let root = RootViewController()

        let dependency = Welcome.Dependency(session: dependency.session)

        var xxx = {

        }

        let welcome = Welcome.build(dependency: dependency) { [unowned root] action in
            switch action {
            case .login:
                let vc = BasicAuth.build(dismiss: {
                    xxx()
                })
                root.use(vc)
            case .register:
                break
            }
        }

        xxx = {
            root.use(welcome)
        }

        root.use(welcome)

        return root
    }
}
