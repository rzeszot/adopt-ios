//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct AnimalDetails {

    static func build() -> AnimalDetailsViewController {
        let vc: AnimalDetailsViewController = UIStoryboard.instantiate(name: "Animal", identifier: "details")
        return vc
    }
}
