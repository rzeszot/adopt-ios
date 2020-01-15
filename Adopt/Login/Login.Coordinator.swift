//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

extension Login {

    class Coordinator: LoginViewControllerDelegate {
        
        // MARK: -

        let perform: (Service.Input) -> Void
        
        let dismiss: () -> Void
        let goto: (Modal) -> Void

        // MARK: -

        init(perform: @escaping (Service.Input) -> Void, dismiss: @escaping () -> Void, goto: @escaping (Modal) -> Void) {
            self.perform = perform
            self.dismiss = dismiss
            self.goto = goto
        }

        // MARK: - LoginViewControllerDelegate

        func login(_ vc: LoginViewController, didLoginWith email: String, and password: String) {
            perform(Service.Input(email: email, password: password))
        }

        func loginDidClose(_ vc: LoginViewController) {
            dismiss()
        }

        func loginDidTapRegister(_ vc: LoginViewController) {
            goto(.register)
        }
    }

}
