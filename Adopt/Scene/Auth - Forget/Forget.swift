//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Forget {
    struct Dependency {
        let guest: Session.Guest
        let dismiss: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: ForgetViewController = UIStoryboard.instantiate(name: "BasicAuth", identifier: "forget")
        root.dismiss = dependency.dismiss
        return root
    }
}
