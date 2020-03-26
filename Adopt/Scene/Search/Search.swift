//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Search {
    struct Dependency {

    }

    static func build(dependency: Dependency) -> UISearchController {
        let result: SearchViewController = UIStoryboard.instantiate(name: "Search", identifier: "search")
        result.view.backgroundColor = .red

        let search = UISearchController(searchResultsController: result)
        search.searchResultsUpdater = result
        search.showsSearchResultsController = true

        return search
    }
}
