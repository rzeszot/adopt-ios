import Foundation

public struct Fixture {
  public let string: String

  public var data: Data {
    string.data(using: .utf8)!
  }
}

extension Fixture: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    string = value
  }
}
