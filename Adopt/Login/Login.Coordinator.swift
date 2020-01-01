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

        let login: (Output) -> Void
        let move: (Target) -> Void

        var service: Service

        init(login: @escaping (Output) -> Void, move: @escaping (Target) -> Void, service: Service = .init()) {
            self.login = login
            self.move = move
            self.service = service
        }

        // MARK: - LoginViewControllerDelegate

        func login(_ vc: LoginViewController, didLoginWith email: String, and password: String) {
            service.perform(.init(email: email, password: password)) { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.login(Output(email: email, token: success.token))
                    }
                    break
                case .failure:
                    print("failure")
                    break
                }
            }
        }

        func loginDidClose(_ vc: LoginViewController) {
            move(.close)
        }

        func loginDidForget(_ vc: LoginViewController) {
            move(.forget)
        }
    }
}
