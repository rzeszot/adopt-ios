//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct AnimalList {
    struct Dependency {
        let categories: CategoriesModel
        let details: () -> Void
        let category: (CategoriesModel.Category) -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: AnimalListViewController = UIStoryboard.instantiate(name: "Animal", identifier: "list")
        root.model = AnimalsListModel(categories: AnimalsListModel.Categories(dependency.categories))
        root.details = dependency.details
        root.category = dependency.category

        let result = Search.build(dependency: Search.Dependency())
        root.navigationItem.searchController = result

        return root
    }
}

private extension AnimalsListModel.Categories {
    init(_ categories: CategoriesModel) {
        self.items = categories.categories.map(AnimalsListModel.Category.init)
    }
}

private extension AnimalsListModel.Category {
    init(_ value: CategoriesModel.Category) {
        id = value.id
        name = value.name
    }
}
