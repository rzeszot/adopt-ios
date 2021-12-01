import SwiftUI

struct AuthorizedView: View {
  let logout: () -> Void

  var body: some View {
    MainView(logout: logout)
  }
}
