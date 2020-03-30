//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct Home {
    struct Dependency {
        let logout: () -> Void

    }

    static func build(dependency: Dependency) -> UIViewController {
        let root = AnimalsContainerViewController()
        root.service = Start.Service(url: .start)
        root.tabBarItem.title = "Home"
        root.tabBarItem.image = UIImage(systemName: "house")
        root.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        return root
    }
}

class AnimalsContainerViewController: StateViewController<Start.Model> {

    var service: Start.Service!

    override func transform(_ state: State<Start.Model>) -> UIViewController {
        if case .data(let model) = state {
            return Recent.build(dependency: Recent.Dependency(categories: model.categories, animals: model.animals.map { Recent.Animal(id: $0.id, name: $0.name) }, details: { [unowned self] in
                let vc = Details.build()
                self.show(vc, sender: nil)
            }, category: { [unowned self] category in
                var xxx = {}

                let vc = Creature.build(dependency: Creature.Dependency(category: .init(id: category.id, name: category.name), filter: {
                    xxx()
                }))

                xxx = { [unowned vc] in
                    let filters = Filters.build(dependency: Filters.Dependency(category: .init(id: category.id), dismiss: {
                        self.dismiss(animated: true)
                    }))
                    let nav = UINavigationController(rootViewController: filters)
                    nav.navigationBar.prefersLargeTitles = true
                    vc.present(nav, animated: true)
                }

                self.show(vc, sender: nil)
            }))
        } else {
            return super.transform(state)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Adopt!"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)

        if let success = service.load() {
            self.change(.data(Start.Model(success)))
        } else {
            change(.loading)

            service.fetch(completion: DispatchQueue.main.wrap { result in
                switch result {
                case .success(let success):
                    self.change(.data(Start.Model(success)))
                case .failure(let error):
                    self.change(.error(error))
                }
            })
        }
    }
}

private extension Start.Model {
    init(_ success: Start.Success) {
        categories = success.categories
        animals = success.animals
    }
}

private extension URL {
    static var start: URL {
        "https://adopt-api.herokuapp.com/start"
    }
}
