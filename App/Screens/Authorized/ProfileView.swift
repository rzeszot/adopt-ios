import SwiftUI

struct ProfileView: View {
  let logout: () -> Void

  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        Text("Profile")
        Spacer()
        Divider()
      }
      .background(.yellow)
      .navigationBarItems(trailing: Button(action: logout) {
        Text("Logout")
      })
    }
  }
}
