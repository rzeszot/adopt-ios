//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Recent {

    // MARK: - Context

    struct Animal {
        let id: String
        let name: String
    }

    typealias Category = Start.Category

    // MARK: - Model

    struct Model {
        let categories: [Category]
        let animals: [Animal]
    }

    // MARK: - Builder

    struct Dependency {
        let categories: [Category]
        let animals: [Animal]

        let details: () -> Void
        let category: (Category) -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: RecentViewController = UIStoryboard.instantiate(name: "Animal", identifier: "list")
        let model = Model(categories: dependency.categories, animals: dependency.animals)

        root.model = model
        root.details = dependency.details
        root.category = dependency.category

        let result = Search.build(dependency: Search.Dependency())
        root.navigationItem.searchController = result

        return root
    }
}
