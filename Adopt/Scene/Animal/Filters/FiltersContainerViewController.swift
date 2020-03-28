//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class FiltersContainerViewController: StateViewController<FiltersModel> {

    var dismiss: (() -> Void)!

    @objc
    func dismissAction() {
        dismiss()
    }

    override func transform(_ state: State<FiltersModel>) -> UIViewController {
        if case .data(let model) = state {
            let vc: FiltersViewController = UIStoryboard.instantiate(name: "Filters", identifier: "filters")
            vc.model = model
            return vc
        } else {
            return super.transform(state)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Filters"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissAction))

        change(.loading)

        let service = FiltersService(url: .heroku)
        service.fetch(completion: DispatchQueue.main.wrap { result in
            switch result {
            case .success(let success):
                self.change(.data(FiltersModel(success)))
            case .failure(let error):
                self.change(.error(error))
            }
        })
    }

}

extension FiltersModel {
    init(_ result: FiltersService.Success) {
        groups = result.filters.map(Group.init)
    }
}

extension FiltersModel.Group {
    init(_ result: FiltersService.Success.Filter) {
        meta = Meta(id: result.id, name: result.name)
        items = result.items.map(Item.init)
    }
}

extension FiltersModel.Group.Item {
    init(_ result: FiltersService.Success.Filter.Item) {
        id = result.id
        name = result.name
        active = result.active ?? false
    }
}

private extension URL {
    static var localhost: URL {
        "http://localhost:4567/filters"
    }
    static var heroku: URL {
        "https://adopt-api.herokuapp.com/filters"
    }
}
