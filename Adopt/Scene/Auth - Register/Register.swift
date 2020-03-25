//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Register {
    struct Dependency {
        let guest: Session.Guest
        let dismiss: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let register: RegisterViewController = UIStoryboard.instantiate(name: "BasicAuth", identifier: "register")
        register.dismiss = dependency.dismiss
        return register
    }
}
