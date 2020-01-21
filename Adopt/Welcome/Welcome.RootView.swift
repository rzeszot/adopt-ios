//
//  Adopt
//
//  Created by Kinga on 13/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Welcome {

    struct RootView: View {
        
        // MARK: -

        @EnvironmentObject
        var session: Session
        
        // MARK: -

        @State
        private var modal: Modal?

        // MARK: -

        var body: some View {
            IntroView(action: { self.modal = $0 })
                .sheet(item: $modal, content: subview(for:))
        }

        private var login: some View {
            Auth.RootView(dismiss: {
                self.modal = nil
            }, goto: { modal in
                guard modal == .register else { return }
                self.modal = .register
            }, finish: { output in
                self.session.login(Session.Credential(email: output.email, token: output.token))
            })
            .environmentObject(Auth.Service())
        }
        
        private var register: some View {
            SignUpView(action: { data in
                self.session.login(Session.Credential(email: data.email,token: data.token))
            })
        }
        
        private func subview(for modal: Modal) -> some View {
            switch modal {
            case .login:
                return AnyView(self.login)
            case .register:
                return AnyView(self.register)
            }
        }
    }

}

struct Welcome_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome.RootView()
    }
}
