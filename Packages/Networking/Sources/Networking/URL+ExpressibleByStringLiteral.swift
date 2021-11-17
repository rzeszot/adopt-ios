import Foundation

extension URL: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(string: value)!
  }
}
