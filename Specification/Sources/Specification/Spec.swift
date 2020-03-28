//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

public protocol Spec {
    associatedtype T

    func satisfied(by value: T) -> Bool
}
