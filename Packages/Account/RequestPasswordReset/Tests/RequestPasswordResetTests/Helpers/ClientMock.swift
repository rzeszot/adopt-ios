import XCTest
@testable import RequestPasswordReset

enum Behaviour {
  case success
  case failure
  case fatal
}

struct ClientMock: Client {
  let behaviour: Behaviour

  func request(username: String) async throws {
    switch behaviour {
    case .success:
      break // do nothing
    case .failure:
      throw RemoteClient.FailureResponse()
    case .fatal:
      fatalError()
    }
  }
}
