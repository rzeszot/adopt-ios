//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

extension Array {
    public func filter(spec: AnySpec<Element>) -> [Element] {
        filter(spec.satisfied(by:))
    }

    public func filter<S: Spec>(spec: S) -> [Element] where S.T == Element {
        filter(spec: spec.erasured())
    }
}
