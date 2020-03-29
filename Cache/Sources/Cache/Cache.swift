//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

public class Cache<Key: Hashable, Object> {

    // MARK: -

    private let store = NSCache<WrappedKey<Key>, WrappedObject<Key, Object>>()
    private let tracker = Tracker<Key, Object>()

    // MARK: -

    public init() {
        store.delegate = tracker
    }

    public subscript(key: Key) -> Object? {
        get {
            object(for: key)?.object
        }
        set {
            if let value = newValue {
                set(value, for: key)
            } else {
                remove(key: key)
            }
        }
    }

    // MARK: -

    private func object(for key: Key) -> WrappedObject<Key, Object>? {
        if let object = store.object(forKey: WrappedKey(key: key)) {
            return object
        } else {
            return nil
        }
    }

    private func set(_ object: Object, for key: Key) {
        let object = WrappedObject(key: key, object: object)
        let key = WrappedKey(key: key)

        tracker.insert(key: object.key)
        store.setObject(object, forKey: key)
    }

    private func remove(key: Key) {
        let key = WrappedKey(key: key)
        store.removeObject(forKey: key)
    }

}
