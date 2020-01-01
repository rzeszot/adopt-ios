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
        let move: (Target) -> Void

        init(perform: @escaping (Service.Input) -> Void, move: @escaping (Target) -> Void) {
            self.perform = perform
            self.move = move
        }

        // MARK: - LoginViewControllerDelegate

        func login(_ vc: LoginViewController, didLoginWith email: String, and password: String) {
            perform(Service.Input(email: email, password: password))
        }

        func loginDidClose(_ vc: LoginViewController) {
            move(.close)
        }

        func loginDidForget(_ vc: LoginViewController) {
            move(.forget)
        }
    }
}
