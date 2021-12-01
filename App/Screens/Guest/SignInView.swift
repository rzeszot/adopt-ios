import SwiftUI

struct SignInView: View {
  let back: () -> Void
  let login: () -> Void
  let remind: () -> Void

  @State var username: String = ""
  @State var password: String = ""

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
        TextField("", text: $username, prompt: Text("Username"))
        TextField("", text: $password, prompt: Text("Password"))

        HStack {
          Spacer()
          Button(action:remind) {
            Text("Remind password")
              .font(.callout)
          }
        }

        Button(action: login) {
          Spacer()
          Text("Login")
            .padding(10)
          Spacer()
        }
        .buttonStyle(.borderedProminent)
      }
      .textFieldStyle(.roundedBorder)
      .padding(30)

      Spacer()

      Divider()
      Text("SignInView")
    }
    .background(.green)
  }
}
