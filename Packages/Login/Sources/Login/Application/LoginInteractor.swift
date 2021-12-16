import Foundation

struct LoginInteractor: LoginUseCaseInput {
  let output: LoginUseCaseOutput
  let gateway: LoginNetworkGateway

  func login(username: String, password: String) {
    Task {
      await login(username: username, password: password)
    }
  }

  // MARK: -

  func login(username: String, password: String) async {
    do {
      let request = LoginRequest(username: username, password: password)
      let success = try await gateway.perform(request)

      output.done(success: LoginSuccess(token: success.token))
    } catch is InvalidCredentialsResponse {
      output.show(failure: .credentials)
    } catch {
      output.show(failure: .other)
    }
  }

}
