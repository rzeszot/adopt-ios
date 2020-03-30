//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

struct AnimalsListModel {

    struct Animal {
        let id: String
        let thumbnail: URL?
        let name: String
    }

    let categories: CategoriesModel
    let animals: [Animal]
}
