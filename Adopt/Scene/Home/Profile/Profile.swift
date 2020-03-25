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
            var xxx = {}

            let vc = Settings.build(dependency: .init(logout: dependency.logout, appearance: {
                xxx()
            }))

            xxx = { [unowned vc] in
                let appearance = SettingsAppearance.build()
                vc.show(appearance, sender: nil)
            }

            root.show(vc, sender: nil)
        }

        return root
    }
}
