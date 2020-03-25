//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Settings {
    struct Dependency {
        let logout: () -> Void
        let appearance: () -> Void
    }

    class Coordinator {
        var dismiss: (() -> Void)!
        var appearance: (() -> Void)!

        func logout() {
            dismiss()
        }
    }

    static func build(dependency: Dependency) -> UIViewController {
        let vc: SettingsViewController = UIStoryboard.instantiate(name: "Settings", identifier: "settings")
        let coordinator = Coordinator()

        vc.coordinator = coordinator

        coordinator.dismiss = dependency.logout
        coordinator.appearance = dependency.appearance

        return vc
    }
}
