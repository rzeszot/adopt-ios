//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

public struct LoginService {

    // MARK: -

    public struct Success: Decodable {
        let token: String
    }

    public enum Failure: Error {
        case invalid
        case error(Error)
        case unknown
    }

    public typealias Output = Result<Success, Failure>

    // MARK: -

    let url: URL
    let session: URLSession

    public init(url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    // MARK: -

    public func perform(email: String, password: String, completion: @escaping (Output) -> Void) {
        let input = Input(email: email, password: password)

        let complete = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        let task = session.dataTask(with: request(for: input)) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                let decoder = JSONDecoder()

                do {
                    switch response.statusCode {
                    case 200: // OK
                        let success = try decoder.decode(Success.self, from: data)
                        complete(.success(success))
                    case 401: // Unauthorized
                        complete(.failure(.invalid))
                    default:
                        complete(.failure(.unknown))
                    }
                } catch {
                    complete(.failure(.error(error)))
                }
            } else if let error = error {
                complete(.failure(.error(error)))
            } else {
                complete(.failure(.unknown))
            }
        }

        task.resume()
    }

    // MARK: -

    struct Input: Encodable {
        let email: String
        let password: String
    }

    func request(for input: Input) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")

        let encoder = JSONEncoder()

        #if DEBUG
            encoder.outputFormatting = .prettyPrinted
        #endif

        do {
            request.httpBody = try encoder.encode(input)
        } catch {
            #if DEBUG
                print("FATAL: encoding Input \(error)")
            #endif
        }

        return request
    }

}
