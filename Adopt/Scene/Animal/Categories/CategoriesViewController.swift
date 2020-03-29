//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    // MARK: -

    var filter: (() -> Void)!
    var category: CategoriesModel.Category!

    // MARK: -

    @IBAction
    func filterAction() {
        filter()
    }

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = category.name
    }

}
