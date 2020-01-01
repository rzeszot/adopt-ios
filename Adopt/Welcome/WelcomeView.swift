//
//  WelcomeView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {

    @EnvironmentObject
    var session: Session

    enum Modal: String, Identifiable {
        var id: String {
            rawValue
        }

        case login
        case register
    }

    @State
    var modal: Modal?

    @State
    var forget: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            Spacer()

            Button(action: {
                self.modal = .login
            }, label: {
                HStack {
                    Spacer()
                    Text("Log In to Existing Account")
                        .foregroundColor(Color(.systemBackground))
                    Spacer()
                }
                .padding(14)
                .background(Color.accentColor)
                .cornerRadius(5)
            })

            Button(action: {
                self.modal = .register
            }, label: {
                HStack {
                    Spacer()
                    Text("Create New Account")
                    Spacer()
                }
                .padding(14)
            })
        }
        .padding(.horizontal, 20)
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
