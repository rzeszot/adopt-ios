//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Login {

    struct Wrapper: UIViewControllerRepresentable {
        var perform: (Service.Input) -> Void
        var move: (Coordinator.Target) -> Void

        func makeUIViewController(context: UIViewControllerRepresentableContext<Wrapper>) -> LoginViewController {
            let vc = LoginViewController()
            vc.delegate = context.coordinator
            return vc
        }

        func updateUIViewController(_ vc: LoginViewController, context: UIViewControllerRepresentableContext<Wrapper>) {

        }

        func makeCoordinator() -> Coordinator {
            return Coordinator(perform: perform, move: move)
        }
    }

}
