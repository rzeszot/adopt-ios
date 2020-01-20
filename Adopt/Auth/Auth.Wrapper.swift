//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Auth {

    struct Wrapper: UIViewControllerRepresentable {
        
        // MARK: -

        private let root = UIViewController()
        private let login = LoginViewController()
        private let password = PasswordViewController()
        
        // MARK: -

        let perform: (Service.Input) -> Void

        let dismiss: () -> Void
        let goto: (Modal) -> Void

        // MARK: - UIViewControllerRepresentable

        func makeUIViewController(context: UIViewControllerRepresentableContext<Wrapper>) -> UIViewController {
            root.addChild(login)
            login.didMove(toParent: root)
            
            root.addChild(password)
            password.didMove(toParent: root)
            
            login.delegate = context.coordinator
            password.delegate = context.coordinator

            return root
        }

        func updateUIViewController(_ vc: UIViewController, context: UIViewControllerRepresentableContext<Wrapper>) {

        }

        func makeCoordinator() -> Coordinator {
            Coordinator(root: root, login: login, password: password, perform: perform, dismiss: dismiss, goto: goto)
        }
    }

}
