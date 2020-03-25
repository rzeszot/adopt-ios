//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Dashboard {
    struct Dependency {
        let user: Session.User
        let logout: () -> Void
    }

    static func build(dependency: Dependency) -> UIViewController {
        let root = UITabBarController()
        var vcs: [UIViewController] = []

        let home = Home.build(dependency: .init(logout: dependency.logout))
        vcs.append(home.nav())

        let search = Search.build(dependency: .init())
        vcs.append(search.nav())

        let notifications = UIViewController()
        notifications.tabBarItem.title = "Notifications"
        notifications.tabBarItem.image = UIImage(systemName: "bell")
        vcs.append(notifications.nav())

        root.setViewControllers(vcs, animated: false)
        return root
    }
}

private extension UIViewController {
    func nav() -> UIViewController {
        let nav = UINavigationController(rootViewController: self)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
