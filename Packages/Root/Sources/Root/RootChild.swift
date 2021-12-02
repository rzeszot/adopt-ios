import Foundation

public struct RootChild: Hashable, Equatable, ExpressibleByStringLiteral {
  public let name: String

  public init(name: String) {
    self.name = name
  }

  public init(stringLiteral value: String) {
    self.init(name: value)
  }
}

extension RootChild {
  public static let welcome: RootChild = "welcome"
  public static let guest: RootChild = "guest"
  public static let user: RootChild = "user"
}
