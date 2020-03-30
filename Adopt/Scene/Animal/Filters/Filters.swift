//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import Cache

struct Filters {

    struct Category {
        let id: String
    }

    // MARK: - Model

    struct Model {
        struct Group {
            struct Item {
                let id: String
                let name: String
                let active: Bool
            }

            struct Meta {
                let id: String
                let name: String
            }

            let meta: Meta
            let items: [Item]
        }

        let groups: [Group]
    }

    // MARK: - Service

    struct Success: Decodable {
        struct Filter: Decodable {
            struct Item: Decodable {
                let id: String
                let name: String
                let active: Bool?
            }

            let id: String
            let name: String
            let items: [Item]
        }
        let filters: [Filter]
    }

    typealias Service = GenericFetcher<Success>

    // MARK: - Builder

    struct Dependency {
        let category: Category
        let dismiss: () -> Void
    }

    static let cache = Cache<URL, Success>()

    static func build(dependency: Dependency) -> UIViewController {
        let root = FiltersContainerViewController()
        root.service = Service(url: .filters(for: dependency.category.id), cache: cache)
        root.dismiss = dependency.dismiss
        return root
    }
}

private extension URL {
    static func filters(for category: String) -> URL {
        "https://adopt-api.herokuapp.com/category/\(category)/filters"
    }
}

extension Filters.Model {
    init(_ result: Filters.Success) {
        groups = result.filters.map(Group.init)
    }
}

extension Filters.Model.Group {
    init(_ result: Filters.Success.Filter) {
        meta = Meta(id: result.id, name: result.name)
        items = result.items.map(Item.init)
    }
}

extension Filters.Model.Group.Item {
    init(_ result: Filters.Success.Filter.Item) {
        id = result.id
        name = result.name
        active = result.active ?? false
    }
}
