//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation
import UIKit

extension Auth {

    class Coordinator: LoginViewControllerDelegate, PasswordViewControllerDelegate {
        
        struct State {
            var email: String?
            var password: String?
        }
        
        private var state: State = .init(email: nil, password: nil)
        
        private let login: LoginViewController
        private let password: PasswordViewController
        private let root: UIViewController

        // MARK: -

        let perform: (Service.Input) -> Void
        
        let dismiss: () -> Void
        let goto: (Modal) -> Void

        // MARK: -

        init(root: UIViewController, login: LoginViewController, password: PasswordViewController, perform: @escaping (Service.Input) -> Void, dismiss: @escaping () -> Void, goto: @escaping (Modal) -> Void) {
            self.perform = perform
            self.dismiss = dismiss
            self.goto = goto
            
            self.root = root
            self.login = login
            self.password = password
            
            inject(login.view, into: root.view)
        }
        
        private func inject(_ subview: UIView, into view: UIView) {
            view.addSubview(subview)

            subview.translatesAutoresizingMaskIntoConstraints = false

            subview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            subview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            subview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        private func transition(from: UIViewController, to: UIViewController) {
            UIView.animate(withDuration: 0.3, animations: {
                from.view.alpha = 0
            }, completion: { _ in                
                from.view.removeFromSuperview()
                
                self.inject(to.view, into: self.root.view)
                to.view.alpha = 0

                UIView.animate(withDuration: 0.3, animations: {
                    to.view.alpha = 1
                }, completion: { _ in
                    
                })
            })
        }

        // MARK: - LoginViewControllerDelegate

        func login(_ vc: LoginViewController, didLoginWithEmail email: String) {
            state.email = email
            
            password.loadViewIfNeeded()
            password.emailLabel.text = email
            
            transition(from: login, to: password)
        }

        func loginDidClose(_ vc: LoginViewController) {
            dismiss()
        }

        func loginDidTapRegister(_ vc: LoginViewController) {
            goto(.register)
        }
        
        // MARK: - PasswordViewControllerDelegate
        
        func password(_ vc: PasswordViewController, didLoginWithPassword password: String) {
            state.password = password
            // TODO: done
        }
        
        func passwordDidBack(_ vc: PasswordViewController) {
            state.password = nil
            transition(from: password, to: login)
        }

    }

}
