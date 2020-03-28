//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

public struct Not<T, S: Spec>: Spec where S.T == T {
    let spec: S

    public func satisfied(by value: T) -> Bool {
        !spec.satisfied(by: value)
    }
}

extension Spec {
    public func not() -> Not<T, Self> {
        Not(spec: self)
    }
}
