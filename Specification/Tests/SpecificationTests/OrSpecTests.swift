//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import XCTest
@testable import Specification

final class OrSpecTests: XCTestCase {

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
        let spec = Greater(than: 5).or(Less(than: 1))

        XCTAssertTrue(spec.satisfied(by: 6))
        XCTAssertTrue(spec.satisfied(by: 0))

        XCTAssertFalse(spec.satisfied(by: 5))
        XCTAssertFalse(spec.satisfied(by: 3))
        XCTAssertFalse(spec.satisfied(by: 1))
    }

    // MARK: -

    static var allTests = [
        ("testExample", testExample)
    ]
}
