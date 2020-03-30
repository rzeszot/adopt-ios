//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

struct Start {

    // MARK: - Context

    struct Category: Decodable {
        let id: String
        let name: String
        let count: Int
    }

    struct Animal: Decodable {
        enum Gender: String, Decodable {
            case male = "gender-male"
            case female = "gender-female"
            case unknown = "gender-unknown"
        }

        let id: String
        let name: String
        let breed: String?
        let gender: Gender
        let content: String
    }

    // MARK: - Model

    typealias Model = Success

    // MARK: - Service

    struct Success: Decodable {
        let categories: [Category]
        let animals: [Animal]
    }

    typealias Service = GenericFetcher<Success>

}
