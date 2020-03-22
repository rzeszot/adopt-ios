//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Home {
    struct Dependency {
        let logout: () -> Void

    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: HomeViewController = UIStoryboard.instantiate(name: "Home", identifier: "home")

        root.profile = { [unowned root] in
            let vc = Profile.build(dependency: .init(logout: dependency.logout))
            root.show(vc, sender: nil)
        }

        return root
    }
}
