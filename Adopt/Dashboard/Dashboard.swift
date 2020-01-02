//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct Dashboard {

    struct RootView: View {

        var dismiss: () -> Void

        @EnvironmentObject
        var credential: Session.Credential

        var body: some View {
            TabView {
                SwipeWrapper()
                    .edgesIgnoringSafeArea(.all)
                    .tag(0)
                    .tabItem {
                        Image(systemName: "flame")
                    }


                ProfileView(dismiss: dismiss)
                    .tag(1)
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }

}

struct Dashboard_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard.RootView(dismiss: {})
    }
}
