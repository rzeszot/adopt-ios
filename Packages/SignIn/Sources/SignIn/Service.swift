import Foundation

class Service {

  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  // MARK: -

  struct Request: Codable {
    let login: String
    let password: String
  }

  struct Response: Codable {
    let token: String
  }

  enum Error: Swift.Error {

  }

  func login(_ payload: Request) -> URLRequest {
    var request = URLRequest(url: URL(string: "https://adopt.rzeszot.pro/sessions")!)
    request.httpMethod = "POST"
    request.httpBody = try? JSONEncoder().encode(payload)

    return request
  }

  func login(_ payload: Request, completion: @escaping (Result<Response, Swift.Error>) -> Void) {
    let task = session.dataTask(with: login(payload)) { data, response, error in
      if let error = error {
        completion(.failure(error))
      } else if let response = response as? HTTPURLResponse {
        if response.statusCode == 201, let data = data {
          do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            completion(.success(response))
          } catch {
            completion(.failure(error))
          }
        }
      } else {
        fatalError()
      }
    }
    task.resume()
  }

}

//    OST  Create  201 (Created), 'Location' header with link to /customers/{id} containing new ID.?
