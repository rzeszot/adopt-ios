//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

struct StartModel {
    let categories: CategoriesModel
    let animals: AnimalsListModel
}

struct Home {
    struct Dependency {
        let logout: () -> Void

    }

    static func build(dependency: Dependency) -> UIViewController {
        let root = AnimalsContainerViewController()
        root.service = StartService(url: .heroku)
        root.tabBarItem.title = "Home"
        root.tabBarItem.image = UIImage(systemName: "house")
        root.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        return root
    }
}

class AnimalsContainerViewController: StateViewController<StartModel> {

    var service: StartService!

    override func transform(_ state: State<StartModel>) -> UIViewController {
        if case .data(let model) = state {
            return AnimalList.build(dependency: AnimalList.Dependency(categories: model.categories, animals: model.animals, details: { [unowned self] in
                let vc = AnimalDetails.build()
                self.show(vc, sender: nil)
            }, category: { [unowned self] category in
                var xxx = {}

                let vc = Categories.build(dependency: Categories.Dependency(category: category, filter: {
                    xxx()
                }))

                xxx = { [unowned vc] in
                    let filters = Filters.build(dependency: Filters.Dependency(id: category.id, dismiss: {
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
            self.change(.data(StartModel(success)))
        } else {
            change(.loading)

            service.fetch(completion: DispatchQueue.main.wrap { result in
                switch result {
                case .success(let success):
                    self.change(.data(StartModel(success)))
                case .failure(let error):
                    self.change(.error(error))
                }
            })
        }
    }
}

private extension StartModel {
    init(_ success: StartService.Success) {
        self.categories = CategoriesModel(categories: success.categories)
        self.animals = AnimalsListModel(categories: self.categories, animals: success.animals.map(AnimalsListModel.Animal.init))
    }
}

private extension AnimalsListModel.Animal {
    init(_ success: AnimalsService.Success.Animal) {
        id = success.id
        name = success.name
        thumbnail = nil
    }
}

private extension URL {
    static var localhost: URL {
        "http://localhost:4567/categories"
    }
    static var heroku: URL {
        "https://adopt-api.herokuapp.com/start"
    }
}
