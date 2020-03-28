//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

public struct Or<T, L: Spec, R: Spec>: Spec where T == L.T, T == R.T {
    let lhs: L
    let rhs: R

    public func satisfied(by value: T) -> Bool {
        lhs.satisfied(by: value) || rhs.satisfied(by: value)
    }
}

extension Spec {
    public func or<B: Spec>(_ other: B) -> Or<T, Self, B> {
        Or(lhs: self, rhs: other)
    }
}
