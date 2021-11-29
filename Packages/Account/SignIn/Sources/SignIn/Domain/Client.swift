import Foundation

protocol Client {
  func request(username: String, password: String) async throws
}
