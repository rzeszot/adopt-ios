import Foundation

protocol Client {
  func request(username: String, password: String, code: String) async throws
}
