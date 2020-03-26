//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct AnimalList {
    struct Dependency {
        let details: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: AnimalListViewController = UIStoryboard.instantiate(name: "Animal", identifier: "list")
        root.details = dependency.details

        let result = Search.build(dependency: Search.Dependency())
        root.navigationItem.searchController = result

        return root
    }
}
