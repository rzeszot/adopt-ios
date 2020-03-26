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

        let notifications = UIViewController()
        notifications.view.backgroundColor = .systemBackground
        notifications.tabBarItem.title = "Notifications"
        notifications.tabBarItem.image = UIImage(systemName: "bell")
        notifications.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        vcs.append(notifications.nav())

        let profile = Profile.build(dependency: Profile.Dependency(logout: dependency.logout))
        vcs.append(profile.nav())

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
