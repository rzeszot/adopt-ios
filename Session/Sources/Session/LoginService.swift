//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

public struct LoginService {

    // MARK: -

    struct Input: Encodable {
        let email: String
        let password: String
    }

    // MARK: -

    public let url: URL
    public let session: URLSession = .shared

    // MARK: -

    public func perform(email: String, password: String, completion: @escaping () -> Void) {

    }

    // MARK: -

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

        }

        return request
    }

}



//https://www.instagram.com/accounts/emailsignup/
//https://www.instagram.com/accounts/login/?source=auth_switcher
//https://www.instagram.com/accounts/password/reset/
//https://www.instagram.com/accounts/emailsignup/

//
//
////
////  Copyright © 2020 Damian Rzeszot. All rights reserved.
////
//
//import Foundation
//
//struct Auth {
//

//
//    typealias Result = Swift.Result<Success, Failure>
//
//    struct Success: Decodable {
//        let token: String
//    }
//
//    enum Failure: Error {
//        case invalid
//        case parsing(Error)
//        case unknown
//    }
//
//    let url: URL
//    let session: URLSession = .shared
//
//    func perform(email: String, password: String, completion: @escaping (Result) -> Void) {
//        var request = URLRequest(url: url, timeoutInterval: 10)
//        request.httpMethod = "POST"
//

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
//    }
//
//}
//
//extension Auth {
//    static var localhost: Auth {
//        return Auth(url: "http://localhost:3000/auth/login")
//    }
//}
//
//extension URL: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
//
//    public init(stringLiteral value: String) {
//        self = URL(string: value)!
//    }
//
//}
