//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Home {
    struct Dependency {
        let logout: () -> Void

    }

    static func build(dependency: Dependency) -> UIViewController {
//        let root: HomeViewController = UIStoryboard.instantiate(name: "Home", identifier: "home")
//


        var xxx = {}

        let root = AnimalList.build(dependency: AnimalList.Dependency(details: {
            xxx()
        }))

        xxx = { [unowned root] in
            let vc = AnimalDetails.build()
            root.show(vc, sender: nil)
        }

        return root
    }
}
