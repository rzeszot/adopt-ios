//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import Adopt

class SpecificationTestCase: XCTestCase {

    struct Greater<T: Comparable>: Spec {
        let than: T

        func satisfied(by value: T) -> Bool {
            value > than
        }
    }

    struct Less<T: Comparable>: Spec {
        let than: T

        func satisfied(by value: T) -> Bool {
            value < than
        }
    }

    struct Equal<T: Comparable>: Spec {
        let value: T

        init(to value: T) {
            self.value = value
        }

        func satisfied(by value: T) -> Bool {
            value == value
        }
    }

    func testGreater() {
        let greaterThanFive = Greater(than: 5)

        XCTAssertTrue(greaterThanFive.satisfied(by: 6))
        XCTAssertFalse(greaterThanFive.satisfied(by: 4))
    }

    func testLess() {
        let lessThanFive = Less(than: 5)

        XCTAssertTrue(lessThanFive.satisfied(by: 4))
        XCTAssertFalse(lessThanFive.satisfied(by: 6))
    }

    func testEqual() {
        let equal = Equal(to: 100)

        XCTAssertTrue(equal.satisfied(by: 100))
    }

    func testNot() {
        let equal = Equal(to: 100)
        let not = Not(spec: equal)

        XCTAssertFalse(not.satisfied(by: 100))
    }

    func testNotMethod() {
        let spec = Equal(to: 100).not()

        XCTAssertFalse(spec.satisfied(by: 100))
    }

    func testAnd() {
        let spec = And(lhs: Greater(than: 5), rhs: Less(than: 10))

        XCTAssertTrue(spec.satisfied(by: 7))
    }

    func testAndMethod() {
        let spec = Greater(than: 5).and(Less(than: 10))
        XCTAssertTrue(spec.satisfied(by: 7))
    }

    func testSpecification() {
        struct Animal {
            enum Gender {
                case male
                case female
            }

            let name: String
            let age: Int
            let gender: Gender
        }

        struct Gender: Spec {
            let gender: Animal.Gender

            func satisfied(by value: Animal) -> Bool {
                gender == value.gender
            }
        }

        struct Younger: Spec {
            let than: Int

            func satisfied(by value: Animal) -> Bool {
                value.age < than
            }
        }

        let males = Gender(gender: .male)
        let females = Gender(gender: .female)
        let animals: [Animal] = [
            Animal(name: "Marley", age: 4, gender: .male),
            Animal(name: "Kitten", age: 2, gender: .female)
        ]

        var result = animals.filter(spec: males)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "Marley")

        result = animals.filter(spec: females)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "Kitten")

        let youngFemales = Gender(gender: .female).and(Younger(than: 5)).erasured()
        result = animals.filter(spec: youngFemales)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "Kitten")
    }

}
