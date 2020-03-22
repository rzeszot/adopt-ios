//
//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

class Session {

    class Credentials: Codable {
        let email: String
        let token: String

        init(email: String, token: String) {
            self.email = email
            self.token = token
        }
    }

    private(set) var credentials: Credentials?

    let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.credentials = defaults.credentials(for: "auth")
    }

    func login(_ credentials: Credentials) {
        self.credentials = credentials
        self.defaults.set(credentials, for: "auth")
    }

    func logout() {
        credentials = nil
        defaults.set(nil, for: "auth")
    }

}

private extension UserDefaults {

    func set(_ credentials: Session.Credentials?, for key: String) {
        if let credentials = credentials {
            let value = try? JSONEncoder().encode(credentials)
            set(value, forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    func credentials(for key: String) -> Session.Credentials? {
        guard let value = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(Session.Credentials.self, from: value)
    }

}
