//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

extension Bundle {

    var version: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var build: String? {
        return infoDictionary?[kCFBundleVersionKey as String] as? String
    }

    var display: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }

    var name: String? {
        return infoDictionary?[kCFBundleNameKey as String] as? String
    }

}
