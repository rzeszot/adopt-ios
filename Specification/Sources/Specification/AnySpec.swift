//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

public struct AnySpec<T>: Spec {
    private let satisfier: (T) -> Bool

    init<U: Spec>(spec: U) where T == U.T {
        self.satisfier = spec.satisfied(by:)
    }

    init(satisfier: @escaping (T) -> Bool) {
        self.satisfier = satisfier
    }

    public func satisfied(by value: T) -> Bool {
        satisfier(value)
    }
}

extension Spec {
    public func erasured() -> AnySpec<T> {
        return AnySpec(spec: self)
    }
}
