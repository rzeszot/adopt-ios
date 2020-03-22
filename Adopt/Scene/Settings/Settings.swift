//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Settings {
    struct Dependency {
        let logout: () -> Void
    }

    class Coordinator {
        var dismiss: (() -> Void)!

        func logout() {
            dismiss()
        }
    }

    static func build(dependency: Dependency) -> UIViewController {
        let vc: SettingsViewController = UIStoryboard.instantiate(name: "Settings", identifier: "settings")
        let coordinator = Coordinator()

        vc.coordinator = coordinator

        coordinator.dismiss = dependency.logout

        return vc
    }
}
