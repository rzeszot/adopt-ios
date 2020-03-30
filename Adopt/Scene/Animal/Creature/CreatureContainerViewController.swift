//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class CreatureContainerViewController: StateViewController<Creature.Model> {

    var category: Creature.Category!
    var service: Creature.Service!
    var filter: (() -> Void)!

    @objc
    func filterAction() {
        filter()
    }

    override func transform(_ state: State<Creature.Model>) -> UIViewController {
        if case .data(let model) = state {
            let vc: CreatureViewController = UIStoryboard.instantiate(name: "Creature", identifier: "creature")
            vc.model = model
            vc.select = {
                let details = Details.build()
                vc.show(details, sender: nil)
            }
            return vc
        } else {
            return super.transform(state)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = category.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(filterAction))

        if let success = service.load() {
            self.change(.data(Creature.Model(category: category, animals: success.animals)))
        } else {
            change(.loading)

            service.fetch(completion: DispatchQueue.main.wrap { result in
                switch result {
                case .success(let success):
                    self.change(.data(Creature.Model(category: self.category, animals: success.animals)))
                case .failure(let error):
                    self.change(.error(error))
                }
            })
        }
    }

}
