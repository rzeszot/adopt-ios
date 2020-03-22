//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Welcome {
    enum Action {
        case login
        case register
    }

    struct Dependency {
        let session: Session
        let action: (Action) -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root: WelcomeViewController = UIStoryboard.instantiate(name: "Welcome", identifier: "welcome")

        root.login = { dependency.action(.login) }
        root.register = { dependency.action(.register) }

        return root
    }
}
