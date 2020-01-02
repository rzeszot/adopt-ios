//
//  ProfileView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 02/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    var dismiss: () -> Void

    @EnvironmentObject
    var credential: Session.Credential

    var body: some View {
        VStack {
            Text("Hello, \(credential.email)!")

            Button(action: {
                self.dismiss()
            }, label: {
                Text("logout")
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(dismiss: {})
    }
}
