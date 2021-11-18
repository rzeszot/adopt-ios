import Foundation
import Networking
import Unexpected

struct Service {

  let session: URLSession
  let parser: Parser = [
    SuccessResponse.self,
    UpgradeRequiredResponse.self,
    ServiceUnavailableResponse.self,
    InvalidCredentialsResponse.self
  ]

  // MARK: -

  struct Request: Codable {
    let login: String
    let password: String
  }

  // MARK: -

  struct SuccessResponse: Response {
    static var code = 201

    let token: String

    enum CodingKeys: String, CodingKey {
      case token = "access_token"
    }
  }

  struct UpgradeRequiredResponse: Response, Error {
    static let code = 426
    let url: URL
  }

  struct ServiceUnavailableResponse: Response, Error {
    static let code = 503
  }

  struct InvalidCredentialsResponse: Response, Error {
    static let code = 401
  }

  // MARK: -

  func login(username: String, password: String) -> URLRequest {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

    var request = URLRequest(url: "https://adopt.rzeszot.pro/sessions")
    request.httpMethod = "POST"
    request.httpBody = try! encoder.encode(Request(login: username, password: password))
    return request
  }

  func perform(username: String, password: String) async throws -> SuccessResponse {
    let request = login(username: username, password: password)
    let (data, response) = try await session.data(for: request)
    let object = try parser.parse(response: response as! HTTPURLResponse, data: data)

    if let object = object as? SuccessResponse {
      return object
    } else if let error = object as? Error {
      throw error
    } else {
      throw UnexpectedError()
    }
  }

}
