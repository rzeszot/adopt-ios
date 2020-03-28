//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

struct FiltersModel {
    struct Group {
        struct Item {
            let id: String
            let name: String
            let active: Bool
        }

        struct Meta {
            let id: String
            let name: String
        }

        let meta: Meta
        let items: [Item]
    }

    let groups: [Group]
}
