//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

class WrappedKey<Key: Hashable>: NSObject {

    let key: Key

    init(key: Key) {
        self.key = key
    }

    // MARK: -

    override var hash: Int {
        key.hashValue
    }

    override func isEqual(_ object: Any?) -> Bool {
        (object as? WrappedKey)?.key == key
    }

}
