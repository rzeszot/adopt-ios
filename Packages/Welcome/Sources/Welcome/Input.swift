import Foundation

public struct Input {
  let done: () -> Void
  let privacy: () -> Void

  public init(done: @escaping () -> Void, privacy: @escaping () -> Void) {
    self.done = done
    self.privacy = privacy
  }
}
