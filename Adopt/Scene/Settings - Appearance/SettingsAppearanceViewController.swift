//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class SettingsAppearanceViewController: UITableViewController {

    var data: [UIUserInterfaceStyle] = [
        .unspecified,
        .dark,
        .light
    ]

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.accessoryType = data[indexPath.row] == view.window?.overrideUserInterfaceStyle ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let style = data[indexPath.row]

        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = style
        }

        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }

}
