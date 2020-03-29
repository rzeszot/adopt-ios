//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Categories {
    struct Dependency {
        let category: CategoriesModel.Category
        let filter: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: CategoriesViewController = UIStoryboard.instantiate(name: "Categories", identifier: "categories")
        root.filter = dependency.filter
        root.category = dependency.category

        return root
    }
}
