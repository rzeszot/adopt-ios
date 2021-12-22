import Foundation

// MARK: -

public protocol LoginUseCaseInput {
  func login(username: String, password: String)
}

// MARK: -

public struct LoginSuccess: Equatable {
  public let token: String
}

// MARK: -

public enum LoginFailure: String, Error {
  case credentials
  case other
}

public protocol LoginUseCaseOutput {
  func done(success: LoginSuccess)
  func show(failure: LoginFailure)
}
