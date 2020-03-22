//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Profile {
    struct Dependency {
        let logout: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: ProfileViewController = UIStoryboard.instantiate(name: "Home", identifier: "profile")

        root.settings = { [unowned root] in
            let vc = Settings.build(dependency: .init(logout: dependency.logout))
            root.show(vc, sender: nil)
        }

        return root
    }
}
