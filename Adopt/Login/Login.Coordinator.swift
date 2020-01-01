//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

extension Login {

    typealias Output = Service.Success

    class Coordinator: LoginViewControllerDelegate {
        let login: (Output) -> Void
        let close: () -> Void

        var service: Service

        init(login: @escaping (Output) -> Void, close: @escaping () -> Void, service: Service = .init()) {
            self.login = login
            self.close = close
            self.service = service
        }

        // MARK: - LoginViewControllerDelegate

        func login(_ vc: LoginViewController, didLoginWith email: String, and password: String) {
            service.perform(.init(email: email, password: password)) { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.login(success)
                    }
                    break
                case .failure:
                    print("failure")
                    break
                }
            }
        }

        func loginDidClose(_ vc: LoginViewController) {
            close()
        }

    }
}
