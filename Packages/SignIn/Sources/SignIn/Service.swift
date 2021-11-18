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

  func login(_ payload: Request) -> URLRequest {
    var request = URLRequest(url: "https://adopt.rzeszot.pro/sessions")
    request.httpMethod = "POST"
    request.httpBody = try! JSONEncoder().encode(payload)
    return request
  }

  func login(_ payload: Request, completion: @escaping (Result<SuccessResponse, Error>) -> Void) {
    let request = login(payload)

    fetch(request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      let responses = self.response(for: response!.statusCode)
      guard responses.count == 1 else {
        print("unexpected | found \(responses.count) responses to check for \(request) with status code \(response!.statusCode)")
        completion(.unexpected)
        return
      }
      let response = responses[0]

      do {
        let decoder = JSONDecoder()
        decoder.userInfo[.init(rawValue: "type")!] = response
        let object = try decoder.decode(Wrapper.self, from: data ?? Data()).response

        completion(.init(catching: {
          if let success = object as? SuccessResponse {
            return success
          } else {
            throw (object as? Error) ?? UnexpectedError()
          }
        }))
      } catch {
        completion(.failure(error))
      }
    }
  }

  private func response(for code: Int) -> [Response.Type] {
    let responses: [Response.Type] = [
      SuccessResponse.self,
      UpgradeRequiredError.self,
      ServiceUnavailable.self,
      InvalidCredentialsError.self
    ]

    return responses.filter { $0.code == code }
  }

  private func fetch(_ request: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
    let task = session.dataTask(with: request) { data, response, error in
      completion(data, response as? HTTPURLResponse, error)
    }
    task.resume()
  }

}

struct Wrapper: Decodable {
  let response: Response

  init(from decoder: Decoder) throws {
    let type = decoder.userInfo[.init(rawValue: "type")!]! as! Response.Type
    response = try type.init(from: decoder)
  }
}
