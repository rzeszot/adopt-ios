//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import Cache

struct Filters {
    struct Dependency {
        let dismiss: () -> Void
    }

    static let cache = Cache<URL, FiltersService.Success>()

    static func build(dependency: Dependency) -> UIViewController {
        let root = FiltersContainerViewController()
        root.service = FiltersService(url: .heroku, cache: cache)
        root.dismiss = dependency.dismiss
        return root
    }
}

private extension URL {
    static var localhost: URL {
        "http://localhost:4567/filters"
    }
    static var heroku: URL {
        "https://adopt-api.herokuapp.com/filters"
    }
}
