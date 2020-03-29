//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import Cache

struct Filters {
    struct Dependency {
        let id: String
        let dismiss: () -> Void
    }

    static let cache = Cache<URL, FiltersService.Success>()

    static func build(dependency: Dependency) -> UIViewController {
        let root = FiltersContainerViewController()
        root.service = FiltersService(url: .heroku(for: dependency.id), cache: cache)
        root.dismiss = dependency.dismiss
        return root
    }
}

private extension URL {
    static func heroku(for id: String) -> URL {
        "https://adopt-api.herokuapp.com/category/\(id)/filters"
    }
}
