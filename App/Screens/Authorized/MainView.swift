import SwiftUI

struct MainView: View {
  let logout: () -> Void

  var body: some View {
    TabView {
      DashboardView()
        .tabItem {
          Image(systemName: "house")
          Text("Dashboard")
        }
      FeedView()
        .tabItem {
          Image(systemName: "rectangle.grid.1x2")
          Text("Feed")
        }
      ProfileView(logout: logout)
        .tabItem {
          Image(systemName: "person")
          Text("Profile")
        }
    }
    .background(.mint)
  }
}
