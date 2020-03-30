//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Details {

    // MARK: - Builder

    static func build() -> DetailsViewController {
        let vc: DetailsViewController = UIStoryboard.instantiate(name: "Animal", identifier: "details")
        return vc
    }

}
