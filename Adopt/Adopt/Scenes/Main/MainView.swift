//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }

            NavigationView {
                MessagesView()
            }
            .tabItem {
                Image(systemName: "message")
                Text("Messages")
            }

            NavigationView {
                FavouritesView()
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favourites")
            }

            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
