//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Creature {

    // MARK: - Context

    struct Category {
        let id: String
        let name: String
    }

    typealias Animal = Success.Animal

    // MARK: - Model

    struct Model {
        let category: Category
        let animals: [Animal]
    }

    // MARK: - Service

    struct Success: Decodable {
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
        let animals: [Animal]
    }

    typealias Service = GenericFetcher<Success>

    // MARK: - Builder

    struct Dependency {
        let category: Category
        let filter: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root = CreatureContainerViewController()
        root.navigationItem.title = dependency.category.name
        root.category = dependency.category
        root.filter = dependency.filter
        root.service = Service(url: .animals(in: dependency.category.id.replacingOccurrences(of: "category-", with: "")))
        return root
    }

}

extension URL {
    static func animals(in category: String) -> URL {
        "https://adopt-api.herokuapp.com/category/\(category)/animals"
    }
}
