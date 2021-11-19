import Foundation

public protocol Response: Decodable {
  static var code: Int { get }
}
