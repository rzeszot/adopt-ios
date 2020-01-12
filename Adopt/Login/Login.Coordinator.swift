//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

extension Login {

    struct Output {
        let email: String
        let token: String
    }

    class Coordinator: LoginViewControllerDelegate {
        enum Target {
            case close
            case forget
        }

        let perform: (Service.Input) -> Void
        let action: (Target) -> Void

        init(perform: @escaping (Service.Input) -> Void, action: @escaping (Target) -> Void) {
            self.perform = perform
            self.action = action
        }

        // MARK: - LoginViewControllerDelegate

        func login(_ vc: LoginViewController, didLoginWith email: String, and password: String) {
            perform(Service.Input(email: email, password: password))
        }

        func loginDidClose(_ vc: LoginViewController) {
            action(.close)
        }

        func loginDidForget(_ vc: LoginViewController) {
            action(.forget)
        }
    }
}
