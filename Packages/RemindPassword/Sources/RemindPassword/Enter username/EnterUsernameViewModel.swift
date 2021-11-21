import Foundation

struct EnterUsernameViewModel {
  let username: String?

  init(_ input: Reset) {
    username = input.username
  }
}
