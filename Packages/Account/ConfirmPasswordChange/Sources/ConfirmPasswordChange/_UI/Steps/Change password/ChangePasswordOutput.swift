import Foundation

struct ChangePasswordOutput {
  let close: () -> Void
  let submit: (String) async -> Void
}
