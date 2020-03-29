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
        root.service = CategoriesService(url: .heroku)
        root.tabBarItem.title = "Home"
        root.tabBarItem.image = UIImage(systemName: "house")
        root.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        return root
    }
}

class AnimalsContainerViewController: StateViewController<CategoriesModel> {

    var service: CategoriesService!

    override func transform(_ state: State<CategoriesModel>) -> UIViewController {
        if case .data(let model) = state {
            return AnimalList.build(dependency: AnimalList.Dependency(categories: model, details: { [unowned self] in
                let vc = AnimalDetails.build()
                self.show(vc, sender: nil)
            }, category: { [unowned self] category in
                let vc = Categories.build(dependency: Categories.Dependency(category: category, filter: {
                    let vc = Filters.build(dependency: Filters.Dependency(dismiss: {
                        self.dismiss(animated: true)
                    }))
                    self.present(UINavigationController(rootViewController: vc), animated: true)
                }))
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
            self.change(.data(CategoriesModel(success)))
        } else {
            change(.loading)

            service.fetch(completion: DispatchQueue.main.wrap { result in
                switch result {
                case .success(let success):
                    self.change(.data(CategoriesModel(success)))
                case .failure(let error):
                    self.change(.error(error))
                }
            })
        }
    }
}

private extension CategoriesModel {
    init(_ success: CategoriesService.Success) {
        self.categories = success.categories
    }
}

private extension URL {
    static var localhost: URL {
        "http://localhost:4567/categories"
    }
    static var heroku: URL {
        "https://adopt-api.herokuapp.com/categories"
    }
}
