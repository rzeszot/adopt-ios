//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Filters {
    struct Dependency {
        let dismiss: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root = FiltersContainerViewController()
        root.dismiss = dependency.dismiss
        return root
    }
}
