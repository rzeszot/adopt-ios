//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

protocol Spec {
    associatedtype T
    func satisfied(by value: T) -> Bool
}

// MARK: -

struct AnySpec<T>: Spec {
    private let satisfier: (T) -> Bool

    init<U: Spec>(spec: U) where T == U.T {
        self.satisfier = spec.satisfied(by:)
    }

    init(satisfier: @escaping (T) -> Bool) {
        self.satisfier = satisfier
    }

    func satisfied(by value: T) -> Bool {
        satisfier(value)
    }
}

extension Spec {
    func erasured() -> AnySpec<T> {
        return AnySpec(spec: self)
    }
}

// MARK: -

struct Not<T, S: Spec>: Spec where S.T == T {
    let spec: S

    func satisfied(by value: T) -> Bool {
        !spec.satisfied(by: value)
    }
}

extension Spec {
    func not() -> Not<T, Self> {
        Not(spec: self)
    }
}

// MARK: -

struct And<T, L: Spec, R: Spec>: Spec where T == L.T, T == R.T {
    let lhs: L
    let rhs: R

    func satisfied(by value: T) -> Bool {
        lhs.satisfied(by: value) && rhs.satisfied(by: value)
    }
}

extension Spec {
    func and<B: Spec>(_ other: B) -> And<T, Self, B> {
        And(lhs: self, rhs: other)
    }
}

// MARK: -

struct Xor<T, L: Spec, R: Spec>: Spec where T == L.T, T == R.T {
    let lhs: L
    let rhs: R

    // swiftlint:disable identifier_name
    func satisfied(by value: T) -> Bool {
        let l = lhs.satisfied(by: value)
        let r = rhs.satisfied(by: value)

        return (l || r) && (l != r)
    }
}

extension Spec {
    func xor<B: Spec>(_ other: B) -> Xor<T, Self, B> {
        Xor(lhs: self, rhs: other)
    }
}

// MARK: -

extension Array {
    func filter(spec: AnySpec<Element>) -> [Element] {
        filter(spec.satisfied(by:))
    }

    func filter<S: Spec>(spec: S) -> [Element] where S.T == Element {
        filter(spec: spec.erasured())
    }
}
