//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct Welcome {
    enum Modal: String, Identifiable {
        var id: String {
            rawValue
        }

        case login
        case register
    }

    struct RootView: View {

        @EnvironmentObject
        var session: Session

        @State
        var modal: Modal?

        @State
        var forget: Bool = false

        var body: some View {
            IntroView(action: { self.modal = $0 })
            .sheet(item: $modal, content: { (id: Modal) -> AnyView in
                switch id {
                case .login:
                    return AnyView(self.login)
                case .register:
                    return AnyView(SignUpView(action: { data in
                        self.session.login(Session.Credential(email: data.email,token: data.token))
                    }))
                }
            })
        }

        var login: some View {
                if forget {
                    return AnyView(Forget.RootView(back: { self.forget = false }))
                } else {
                    return AnyView(Login.RootView(finish: { output in
                        self.session.login(Session.Credential(email: output.email, token: output.token))
                    }, move: { target in
                        if target == .close {
                            withAnimation {
                                self.modal = nil
                            }
                        } else if target == .forget {
                            self.forget = true
                        }
                    }))
                }

        }
    }
}

struct Welcome_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome.RootView()
    }
}
