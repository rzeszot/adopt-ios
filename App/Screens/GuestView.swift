import SwiftUI

struct GuestView: View {
  let login: () -> Void

  enum Subview: String, Identifiable {
    case signin
    case confirm
    case request
    case signup

    var id: String {
      rawValue
    }
  }

  @State
  var subview: Subview?

  func content(_ id: Subview) -> some View {
    switch id {
    case .signin:
      return AnyView(SignInView(back: { subview = nil }, login: login, remind: { subview = .request }))
    case .signup:
      return AnyView(SignUpView(back: { subview = nil }, register: login))
    case .request:
      return AnyView(RequestPasswordResetView(back: { subview = nil }))
    case .confirm:
      return AnyView(ConfirmPasswordResetView(back: { subview = nil }, login: login))
    }
  }

  var body: some View {
    VStack {
      Spacer()

      Text("Welcome")
        .font(.largeTitle)

      Spacer()

      HStack {
        Button(action: { subview = .signin }) {
          Text("Sign in").padding(10)
        }
        Button(action: { subview = .signup }) {
          Text("Sign up").padding(10)
        }
      }
      .buttonStyle(.borderedProminent)

      Spacer()
      Divider()

      HStack {
        Button(action: { subview = .request }) {
          Text("Request password reset").padding(5)
        }
        Button(action: { subview = .confirm }) {
          Text("Confirm password reset").padding(5)
        }
      }
      .buttonStyle(.borderedProminent)
      Divider()
      Text("GuestView")
    }
    .sheet(item: $subview, content: content)
  }
}
