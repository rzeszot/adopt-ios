//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Dashboard {
    struct Dependency {
        let logout: () -> Void
        let credentials: Session.Credentials
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root = UITabBarController()
        var vcs: [UIViewController] = []

        let home = Home.build(dependency: .init(logout: dependency.logout))
        vcs.append(UINavigationController(rootViewController: home))

        let search = UIViewController()
        search.tabBarItem.title = "Search"
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vcs.append(UINavigationController(rootViewController: search))

        let notifications = UIViewController()
        notifications.tabBarItem.title = "Notifications"
        notifications.tabBarItem.image = UIImage(systemName: "bell")
        vcs.append(UINavigationController(rootViewController: notifications))

        root.setViewControllers(vcs, animated: false)
        return root
    }
}
