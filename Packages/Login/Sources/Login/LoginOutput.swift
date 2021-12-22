import Foundation

public struct LoginOutput {
  let close: () -> Void

  public init(close: @escaping () -> Void) {
    self.close = close
  }
}
