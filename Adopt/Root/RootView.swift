//
//  RootView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject
    var session: Session

    var body: some View {
        if let credential = session.credential {
            return AnyView(dashboard(with: credential))
        } else {
            return AnyView(Welcome.RootView())
        }
    }

    func dashboard(with credential: Session.Credential) -> some View {
        Dashboard.RootView(dismiss: {
            self.session.logout()
        })
        .environmentObject(credential)
    }

}

extension Identifiable where Self: RawRepresentable {
    var id: RawValue {
        rawValue
    }
}
