//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Search {
    struct Dependency {

    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: SearchViewController = UIStoryboard.instantiate(name: "Search", identifier: "search")

        return root
    }
}
