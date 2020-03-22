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
    }

    static func build(dependency: Dependency, action: @escaping (Action) -> Void) -> UIViewController {
        let root: WelcomeViewController = UIStoryboard.instantiate(name: "Welcome", identifier: "welcome")

        root.login = { action(.login) }
        root.register = { action(.register) }

        return root
    }
}
