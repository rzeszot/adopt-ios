//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Home {
    struct Dependency {
        let logout: () -> Void

    }

    static func build(dependency: Dependency) -> UIViewController {
        var details = {}
        var filter = {}

        let root = AnimalList.build(dependency: AnimalList.Dependency(details: {
            details()
        }, filter: {
            filter()
        }))

        details = { [unowned root] in
            let vc = AnimalDetails.build()
            root.show(vc, sender: nil)
        }

        filter = { [unowned root] in
            let vc = UINavigationController(rootViewController: Filters.build(dependency: .init(dismiss: {
                root.dismiss(animated: true)
            })))
            root.present(vc, animated: true)
        }

        return root
    }
}
