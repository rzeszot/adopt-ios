import SwiftUI

struct ConfirmPasswordResetView: View {
  let back: () -> Void
  let login: () -> Void

  @State var passsword: String = ""
  @State var passsword2: String = ""
  @State var alert: Bool = false

  var body: some View {
    VStack {
      HStack {
        Button(action: back) {
          Image(systemName: "chevron.left")
        }
        .buttonStyle(.bordered)
        .padding(20)
        Spacer()
      }

      Spacer()

      VStack {
        TextField("", text: $passsword, prompt: Text("Password"))
        TextField("", text: $passsword2, prompt: Text("Password confirmation"))

        Button(action: { alert = true }) {
          Spacer()
          Text("Request")
            .padding(10)
          Spacer()
        }
        .buttonStyle(.borderedProminent)
      }
      .textFieldStyle(.roundedBorder)
      .padding(30)

      Spacer()

      Divider()
      Text("ConfirmPasswordResetView")
    }
    .background(.cyan)
    .alert("Password has been changed", isPresented: $alert) {
      Button("OK", role: .cancel, action: login)
    }
  }
}
