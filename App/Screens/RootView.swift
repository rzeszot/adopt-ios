import SwiftUI

struct RootView: View {
  enum Subview: String, Identifiable {
    case guest
    case authorized

    var id: String {
      rawValue
    }
  }

  @State
  var subview: Subview?

  func content(_ id: Subview) -> some View {
    switch id {
    case .authorized:
      return AnyView(AuthorizedView(logout: { subview = .guest }))
    case .guest:
      return AnyView(GuestView(login: { subview = .authorized }))
    }
  }

  var body: some View {
    if let subview = subview {
      content(subview)
    } else {
      VStack {

        Spacer()
        Divider()

        HStack {
          Button(action: { subview = .guest }) {
            Text("Guest").padding(5)
          }
          Button(action: { subview = .authorized }) {
            Text("Authorized").padding(5)
          }
        }
        .buttonStyle(.borderedProminent)

        Divider()
        Text("RootView")
      }
    }
  }
}
