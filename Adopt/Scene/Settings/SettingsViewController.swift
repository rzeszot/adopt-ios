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

        versionLabel.text = "\(bundle.name!) \(bundle.version!) (\(commit))"
    }

    // MARK: -

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            coordinator.appearance()
        case (3, 0):
            logout()
        default:
            break
        }
    }

    // MARK: -

    private func logout() {
        let alert = UIAlertController(title: "Are you sure?", message: "You will be signed off your account. Do you want to sign out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { _ in
            self.coordinator.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true)
    }

}
