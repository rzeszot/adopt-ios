//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

class Tracker<Key: Hashable, Object>: NSObject, NSCacheDelegate {

    // MARK: -

    private(set) var keys = Set<Key>()

    func insert(key: Key) {
        keys.insert(key)
    }

    // MARK: - NSCacheDelegate

    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        guard let object = obj as? WrappedObject<Key, Object> else { return }
        keys.remove(object.key)
    }

}
