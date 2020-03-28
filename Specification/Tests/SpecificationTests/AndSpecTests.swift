//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import Specification

final class AndSpecTests: XCTestCase {

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

    // MARK: -

    func testExample() {
        let spec = Greater(than: 1).and(Less(than: 5))

        XCTAssertTrue(spec.satisfied(by: 2))
        XCTAssertTrue(spec.satisfied(by: 3))
        XCTAssertTrue(spec.satisfied(by: 4))

        XCTAssertFalse(spec.satisfied(by: 1))
        XCTAssertFalse(spec.satisfied(by: 5))
    }

    // MARK: -

    static var allTests = [
        ("testExample", testExample)
    ]
}
