import Foundation

extension URL {
  public static func == (lhs: URL, rhs: String) -> Bool {
    lhs.absoluteString == rhs
  }
}
