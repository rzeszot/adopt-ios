//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Settings {
    struct Dependency {

    }

    class Coordinator {
        var dismiss: (() -> Void)!

        func logout() {
            dismiss()
        }
    }

    static func build(logout: @escaping () -> Void) -> UIViewController {
        let vc: SettingsViewController = UIStoryboard.instantiate(name: "Settings", identifier: "settings")
        let coordinator = Coordinator()

        vc.coordinator = coordinator

        coordinator.dismiss = logout

        return UINavigationController(rootViewController: vc)
    }
}
