import Foundation

public struct LoginOutput {
  public let remind: (String?) -> Void
  public let close: () -> Void
  public let login: () -> Void

  public init(remind: @escaping (String?) -> Void, close: @escaping () -> Void, login: @escaping () -> Void) {
    self.remind = remind
    self.close = close
    self.login = login
  }
}
