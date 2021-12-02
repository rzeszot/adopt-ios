import Foundation

protocol LoginNetworkGateway {
  func perform(_ request: LoginRequest) async throws -> LoginSuccessResponse
}
