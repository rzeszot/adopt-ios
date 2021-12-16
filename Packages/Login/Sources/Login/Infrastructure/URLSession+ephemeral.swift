import Foundation

extension URLSession {
  static var ephemeral: URLSession = URLSession(configuration: .ephemeral)
}
