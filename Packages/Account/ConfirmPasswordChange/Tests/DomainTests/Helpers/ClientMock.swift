@testable import ConfirmPasswordChange

struct ClientMock: Client {
  enum Behaviour {
    case success
    case failure
    case fatal
  }

  let behaviour: Behaviour

  func request(username: String, password: String, code: String) async throws {
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
