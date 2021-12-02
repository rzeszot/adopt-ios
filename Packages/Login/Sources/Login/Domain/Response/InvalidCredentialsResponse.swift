import Networking

struct InvalidCredentialsResponse: Response, Error {
  static var code: Int = 401
}
