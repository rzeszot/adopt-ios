import Foundation

struct Fixture {
  let string: String

  var data: Data {
    string.data(using: .utf8)!
  }
}

extension Fixture: ExpressibleByStringLiteral {
  init(stringLiteral value: String) {
    string = value
  }
}
