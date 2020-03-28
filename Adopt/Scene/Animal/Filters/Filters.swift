//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Filters {

    static func build() -> UIViewController {
        let vc: FiltersViewController = UIStoryboard.instantiate(name: "Filters", identifier: "filters")

        FiltersService().fetch { result in
            // swiftlint:disable:next force_try
            vc.model = FiltersModel(try! result.get())
        }

        return vc
    }
}

private extension FiltersModel {
    init(_ result: FiltersService.Success) {
        groups = result.filters.map(Group.init)
    }
}

private extension FiltersModel.Group {
    init(_ result: FiltersService.Success.Filter) {
        meta = Meta(id: result.id, name: result.name)
        items = result.items.map(Item.init)
    }
}

private extension FiltersModel.Group.Item {
    init(_ result: FiltersService.Success.Filter.Item) {
        id = result.id
        name = result.name
        active = result.active ?? false
    }
}
