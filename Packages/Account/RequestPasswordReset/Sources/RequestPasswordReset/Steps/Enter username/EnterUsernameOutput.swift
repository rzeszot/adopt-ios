import Foundation

struct EnterUsernameOutput {
  let close: () -> Void
  let submit: (String) async -> Void
}