//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct SettingsAppearance {
    static func build() -> UIViewController {
        let vc: SettingsAppearanceViewController = UIStoryboard.instantiate(name: "Settings", identifier: "appearance")
        return vc
    }
}
