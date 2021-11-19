import Foundation

public struct InvalidCredentialsResponse: Response, Error {
  public static let code = 401
}
