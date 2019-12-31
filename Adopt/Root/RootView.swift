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
        if let user = session.user {
            return AnyView(DashboardView().environmentObject(user))
        } else {
            return AnyView(SignInView(action: { data in
                self.session.login(data)
            }))
        }
    }

}
