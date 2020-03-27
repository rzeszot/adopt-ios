//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

extension BasicAuth {
    class Coordinator: LoginViewControllerDelegate, PasswordViewControllerDelegate {

        var root: BasicAuthViewController!
        var login: LoginViewController!
        var password: PasswordViewController!
        var service: Auth!

        var forget: (() -> Void)!
        var dismiss: (() -> Void)!
        var register: (() -> Void)!
        var success: ((Output) -> Void)!

        private var email: String?

        // MARK: - LoginViewControllerDelegate

        func login(_ vc: LoginViewController, didLoginWithEmail email: String) {
            self.email = email
            root.use(password)
        }

        func loginDidClose(_ vc: LoginViewController) {
            dismiss()
        }

        func loginDidTapRegister(_ vc: LoginViewController) {
            register()
        }

        func loginDidTapForget(_ vc: LoginViewController) {
            forget()
        }

        // MARK: - PasswordViewControllerDelegate

        func password(_ vc: PasswordViewController, didLoginWithPassword password: String) {
            guard let email = email else { return }

            service.perform(email: email, password: password) { [weak self] result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self?.success(Output(email: email, token: success.token))
                    }
                case .failure:
                    self?.password.passwordTextField.shake()
                }
            }
        }

        func passwordDidBack(_ vc: PasswordViewController) {
            root.use(login)
        }
    }
}

extension DispatchQueue {

    func wrap<T>(_ completion: @escaping (T) -> Void) -> (T) -> Void {
        return { result in
            self.async {
                completion(result)
            }
        }
    }

    func wrap(_ completion: @escaping () -> Void) -> () -> Void {
        return {
            self.async {
                completion()
            }
        }
    }

}
