import Foundation

protocol LoginUseCaseInput {
  func login(username: String, password: String)
}

protocol LoginUseCaseOutput {
  func done(result: LoginResult)
  func show(error: LoginError)
}

struct LoginInteractor: LoginUseCaseInput {
  let output: LoginUseCaseOutput
  let gateway: LoginNetworkGateway

  func login(username: String, password: String) async {
    do {
      let success = try await gateway.perform(LoginRequest(username: username, password: password))
      output.done(result: LoginResult(token: success.token))
    } catch is InvalidCredentialsResponse {
      output.show(error: .auth)
    } catch {
      output.show(error: .other)
    }
  }

  func login(username: String, password: String) {
    Task {
      await login(username: username, password: password)
    }
  }

}
