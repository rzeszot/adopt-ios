//
//  DashboardView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct DashboardView: View {

    @EnvironmentObject
    var user: Session.User

    var body: some View {
        Text("Hello, \(user.token)!")
    }

}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
