//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

class WrappedObject<Key: Hashable, Object> {

    let key: Key
    let object: Object

    init(key: Key, object: Object) {
        self.key = key
        self.object = object
    }

}
