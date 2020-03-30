//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class FiltersContainerViewController: StateViewController<Filters.Model> {

    var service: Filters.Service!
    var dismiss: (() -> Void)!

    @objc
    func dismissAction() {
        dismiss()
    }

    override func transform(_ state: State<Filters.Model>) -> UIViewController {
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

        if let success = service.load() {
            self.change(.data(Filters.Model(success)))
        } else {
            change(.loading)

            service.fetch(completion: DispatchQueue.main.wrap { result in
                switch result {
                case .success(let success):
                    self.change(.data(Filters.Model(success)))
                case .failure(let error):
                    self.change(.error(error))
                }
            })
        }
    }

}
