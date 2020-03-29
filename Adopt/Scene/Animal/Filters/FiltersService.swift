//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation
import Cache

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
    let cache: Cache<URL, Success>?

    init(url: URL, session: URLSession = .shared, cache: Cache<URL, FiltersService.Success>? = nil) {
        self.url = url
        self.session = session
        self.cache = cache
    }

    // MARK: -

    func load() -> Success? {
        cache?[url]
    }

    // MARK: -

    func fetch(completion: @escaping (Output) -> Void) {
        let complete = DispatchQueue.main.wrap(completion)
        let request = URLRequest(url: url)

        print("Filters | fetch")

        let task = session.dataTask(with: request) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                let decoder = JSONDecoder()
                do {
                    switch response.statusCode {
                    case 200: // OK
                        let success = try decoder.decode(Success.self, from: data)
                        self.cache?[self.url] = success
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
