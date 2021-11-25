import Foundation

class DelayService {
  var returns: Bool?

  init() {}

  @discardableResult
  func execute() async -> Bool {
    await withCheckedContinuation { continuation in
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
        continuation.resume(returning: self.returns ?? .random())
      }
    }
  }
}
