//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

class FiltersService {

    // MARK: -

    struct Success: Decodable {
        struct Filter: Decodable {
            struct Item: Decodable {
                let id: String
                let name: String
                let active: Bool?
            }

            let id: String
            let name: String
            let items: [Item]
        }
        let filters: [Filter]
    }

    enum Failure: Error {
        case error(Error)
        case unknown
    }

    typealias Output = Result<Success, Failure>

    // MARK: -

    let url: URL
    let session: URLSession

    init(url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    // MARK: -

    func fetch(completion: @escaping (Output) -> Void) {
        let request = URLRequest(url: url)
        let complete = DispatchQueue.main.wrap(completion)

        let task = session.dataTask(with: request) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                let decoder = JSONDecoder()
                do {
                    switch response.statusCode {
                    case 200: // OK
                        let success = try decoder.decode(Success.self, from: data)
                        complete(.success(success))
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

}
