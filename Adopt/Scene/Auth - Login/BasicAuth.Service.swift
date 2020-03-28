//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation
import Session

struct Auth {

    struct Input: Encodable {
         let email: String
         let password: String
     }

    typealias Result = Swift.Result<Success, Failure>

    struct Success: Decodable {
        let token: String
    }

    enum Failure: Error {
        case invalid
        case parsing(Error)
        case unknown
    }

    let url: URL
    let session: URLSession = .shared

    func perform(email: String, password: String, completion: @escaping (Result) -> Void) {
//
//        var request = URLRequest(url: url, timeoutInterval: 10)
//        request.httpMethod = "POST"
//
//        do {
//            let encoder = JSONEncoder()
//            request.httpBody = try encoder.encode(Input(email: email, password: password))
//            request.allHTTPHeaderFields?["Content-Type"] = "application/json"
//        } catch {
//            print("FATAL | Auth.perform error: (encode json) \(error)")
//        }
//
//        let task = session.dataTask(with: request) { data, _, _ in
//            let result: Result
//
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let success = try decoder.decode(Success.self, from: data)
//
//                    result = .success(success)
//                } catch {
//                    result = .failure(.parsing(error))
//                }
//            } else {
//                result = .failure(.unknown)
//            }
//
//            DispatchQueue.main.async {
//                completion(result)
//            }
//        }
//
//        task.resume()
    }

}

extension Auth {
    static var localhost: Auth {
        return Auth(url: "http://localhost:3000/auth/login")
    }
}

extension URL: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self = URL(string: value)!
    }

}
