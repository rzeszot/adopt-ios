import SwiftUI

struct SignUpView: View {
  let back: () -> Void
  let register: () -> Void

  @State var username: String = ""
  @State var password: String = ""
  @State var password2: String = ""

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
        TextField("", text: $password2, prompt: Text("Password"))

        Button(action: register) {
          Spacer()
          Text("Register")
            .padding(10)
          Spacer()
        }
        .buttonStyle(.borderedProminent)
      }
      .textFieldStyle(.roundedBorder)
      .padding(30)

      Spacer()

      Divider()
      Text("SignUpView")
    }
    .background(.pink)
  }
}
