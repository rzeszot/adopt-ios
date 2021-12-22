import Networking

public struct InvalidCredentialsResponse: Response, Error {
  public static var code: Int = 401
}
