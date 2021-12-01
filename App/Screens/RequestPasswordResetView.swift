import SwiftUI

struct RequestPasswordResetView: View {
  let back: () -> Void

  @State var username: String = ""
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
        TextField("", text: $username, prompt: Text("Username"))

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
      Text("RequestPasswordResetView")
    }
    .background(.brown)
    .alert("Password reset requested", isPresented: $alert) {
      Button("OK", role: .cancel, action: back) 
    }
  }
}
