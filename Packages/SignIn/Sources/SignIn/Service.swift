import Foundation
import Networking
import Unexpected

protocol Response: Decodable {
  static var code: Int { get }
}

struct Service {
  let session: URLSession

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

  // MARK: -

  struct UpgradeRequiredError: Response, Error {
    static let code = 426
    let url: URL
  }

  struct ServiceUnavailable: Response, Error {
    static let code = 503
  }

  struct InvalidCredentialsError: Response, Error {
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
    let (data, response) = try await fetch(request)

    guard let type = payload(for: response.statusCode) else {
      throw UnexpectedError()
    }

    let decoder = JSONDecoder()
    decoder.userInfo[.init(rawValue: "type")!] = type
    let object = try decoder.decode(Wrapper.self, from: data).response

    if let object = object as? SuccessResponse {
      return object
    } else if let object = object as? Error {
      throw object
    } else {
      throw UnexpectedError()
    }
  }

  private func payload(for code: Int) -> Response.Type? {
    let responses: [Response.Type] = [
      SuccessResponse.self,
      UpgradeRequiredError.self,
      ServiceUnavailable.self,
      InvalidCredentialsError.self
    ]

    precondition(Set(responses.map { $0.code }).count == responses.count)

    return responses.first { $0.code == code }
  }

  private func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
    let (data, response) = try await session.data(for: request)
    return (data, response as! HTTPURLResponse)
  }

}

struct Wrapper: Decodable {
  let response: Response

  init(from decoder: Decoder) throws {
    let type = decoder.userInfo[.init(rawValue: "type")!]! as! Response.Type
    response = try type.init(from: decoder)
  }
}
