//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

extension BasicAuth {
    class Service: ObservableObject {

        // MARK: -

        struct Input {
            let email: String
            let password: String
        }

        // MARK: -

        struct Success: Codable {
            let token: String
        }

        enum Failure: Error {
            case invalid
            case parsing(Error)
            case unknown
        }

        typealias Output = Result<Success, Failure>

        // MARK: -

        func perform(_ input: Input, completion: @escaping (Output) -> Void) {
            let complete = DispatchQueue.main.wrap(completion)

            var request = URLRequest.post("https://adopt.rzeszot.pro/api/auth/sign_in")
            try? request.set(json: ["user": ["email": input.email, "password": input.password]])

            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                print("sign in | done")

                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 400 {
                        complete(.failure(.invalid))
                        return
                    }
                }

                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(Success.self, from: data)
                        complete(.success(response))
                    } catch {
                        complete(.failure(.parsing(error)))
                    }
                } else {
                    complete(.failure(.unknown))
                }
            }

            task.resume()
        }
    }

}

extension URL: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self = URL(string: value)!
    }

}

extension URLRequest {

    static func post(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }

    mutating func set<T: Encodable>(json: T) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(json)

        httpBody = data
        allHTTPHeaderFields?["Content-Type"] = "application/json"
    }

}
