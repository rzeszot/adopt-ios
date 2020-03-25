//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Root {
    struct Dependency {
        enum Actor {
            case guest(Session.Guest)
            case user(Session.User)
        }

        let actor: Actor
    }
}

extension Root {
    static func build(dependency: Dependency) -> UIViewController {
        let root = RootViewController()

        switch dependency.actor {
        case .user(let user):
            root.use(dashboard(dependency: dependency, user: user, route: root.use))
        case .guest(let guest):
            root.use(welcome(dependency: dependency, guest: guest, route: root.use))
        }

        return root
    }

    // MARK: -

    private static func welcome(dependency: Dependency, guest: Session.Guest, route: @escaping (UIViewController) -> Void) -> UIViewController {
        Welcome.build(dependency: Welcome.Dependency(guest: guest, action: { action in
            switch action {
            case .login:
                route(login(dependency: dependency, guest: guest, route: route))
            case .register:
                route(register(dependency: dependency, guest: guest, route: route))
            }
        }))
    }

    private static func login(dependency: Dependency, guest: Session.Guest, route: @escaping (UIViewController) -> Void) -> UIViewController {
        BasicAuth.build(dependency: BasicAuth.Dependency(service: BasicAuth.Service(), success: { output in
            let user = guest.login(Session.Credential(email: output.email, token: output.token))
            route(dashboard(dependency: dependency, user: user, route: route))
        }, dismiss: {
            route(welcome(dependency: dependency, guest: guest, route: route))
        }, register: {
            route(register(dependency: dependency, guest: guest, route: route))
        }))
    }

    private static func register(dependency: Dependency, guest: Session.Guest, route: @escaping (UIViewController) -> Void) -> UIViewController {
        Register.build(dependency: Register.Dependency(guest: guest, dismiss: {
            route(welcome(dependency: dependency, guest: guest, route: route))
        }))
    }

    private static func dashboard(dependency: Dependency, user: Session.User, route: @escaping (UIViewController) -> Void) -> UIViewController {
        Dashboard.build(dependency: Dashboard.Dependency(user: user, logout: {
            route(welcome(dependency: dependency, guest: user.logout(), route: route))
        }))
    }

}
