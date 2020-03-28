//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//
// swiftlint:disable force_try

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
        case unknown
    }

    typealias Output = Result<Success, Failure>

    // MARK: -

    func fetch(completion: @escaping (Output) -> Void) {
        let payload = try! Data(contentsOf: Bundle.main.url(forResource: "Filters", withExtension: "json")!)

        let decoder = JSONDecoder()
        let success = try! decoder.decode(Success.self, from: payload)

        completion(.success(success))
    }

}
