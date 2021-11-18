import Networking
import Foundation

extension HTTPURLResponse {
  static func status(_ code: Int) -> HTTPURLResponse {
    .init(url: "https://example.org", statusCode: code, httpVersion: nil, headerFields: nil)!
  }
}
