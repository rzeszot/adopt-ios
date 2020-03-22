//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    // MARK: -

    var coordinator: Settings.Coordinator!

    // MARK: -

    @IBOutlet
    var versionLabel: UILabel!

    // MARK: -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let bundle = Bundle.main
        let commit = Build.git.commit.prefix(10)

        versionLabel.text = "Version \(bundle.version!) (\(commit))"
    }

    // MARK: -

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            coordinator.logout()
        default:
            break
        }
    }

}
