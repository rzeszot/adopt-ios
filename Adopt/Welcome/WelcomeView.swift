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
                return AnyView(Login.RootView(finish: { output in
                    self.session.login(Session.Credential(token: output.token))
                }, close: {
                    self.modal = nil
                }))
            case .register:
                return AnyView(SignUpView(action: { data in
                    self.session.login(Session.Credential(token: data.token))
                }))
            }
        })
    }

}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
