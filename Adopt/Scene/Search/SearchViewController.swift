//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        print("seach \(text)")
    }

}
