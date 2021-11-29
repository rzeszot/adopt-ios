import Foundation

protocol Client {
  func request(username: String) async throws
}
