//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct BasicAuth {
    struct Dependency {
        let service: Service
    }

    struct Output {
        let email: String
        let token: String
    }
}

extension BasicAuth {
    static func build(dependency: Dependency, success: @escaping (Output) -> Void, dismiss: @escaping () -> Void) -> UIViewController {
        let root = BasicAuthViewController()
        let coordinator = Coordinator()

        let login: LoginViewController = UIStoryboard.instantiate(name: "BasicAuth", identifier: "email")
        let password: PasswordViewController = UIStoryboard.instantiate(name: "BasicAuth", identifier: "password")

        coordinator.dismiss = dismiss
        coordinator.success = success
        coordinator.root = root
        coordinator.login = login
        coordinator.password = password
        coordinator.service = dependency.service

        login.delegate = coordinator

        password.delegate = coordinator

        root.coordinator = coordinator
        root.use(login)

        return root
    }
}
