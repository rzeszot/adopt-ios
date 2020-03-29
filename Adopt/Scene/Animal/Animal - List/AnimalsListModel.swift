//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

struct AnimalsListModel {
    struct Category {
        let id: UUID = .init()
        let name: String
    }

    struct Categories {
        let items: [Category]
    }

    struct Animal {
        let id: UUID = .init()
        let thumbnail: URL = "https://placekitten.com/400/300?image=\((1...16).randomElement()!)"
        let name: String
    }

    struct Animals {
        let items: [Animal]
    }

    let categories: Categories
    let animals: Animals

    init(categories: Categories) {
        self.categories = categories
        animals = Animals(items: (0..<20).map { _ in Animal(name: "xxxxxx") })
    }
}
