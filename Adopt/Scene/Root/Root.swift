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

        if let credentials = dependency.session.credentials {
            root.use(dashboard(dependency: dependency, credentials: credentials, route: root.use))
        } else {
            root.use(welcome(dependency: dependency, route: root.use))
        }

        return root
    }

    // MARK: -

    private static func welcome(dependency: Dependency, route: @escaping (UIViewController) -> Void) -> UIViewController {
        Welcome.build(dependency: Welcome.Dependency(session: dependency.session, action: { action in
            guard case .login = action else { return }
            route(login(dependency: dependency, route: route))
        }))
    }

    private static func login(dependency: Dependency, route: @escaping (UIViewController) -> Void) -> UIViewController {
        BasicAuth.build(dependency: BasicAuth.Dependency(session: dependency.session, service: BasicAuth.Service(), success: { output in
            let credential = Session.Credentials(email: output.email, token: output.token)
            dependency.session.login(credential)
            route(dashboard(dependency: dependency, credentials: credential, route: route))
        }, dismiss: {
            route(welcome(dependency: dependency, route: route))
        }))
    }

    private static func dashboard(dependency: Dependency, credentials: Session.Credentials, route: @escaping (UIViewController) -> Void) -> UIViewController {
        Dashboard.build(dependency: Dashboard.Dependency(logout: {
            route(welcome(dependency: dependency, route: route))
        }, credentials: dependency.session.credentials!))
    }

}
