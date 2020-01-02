//
//  Session.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

class Session: ObservableObject {

    class Credential: Codable, ObservableObject {
        let email: String
        let token: String

        init(email: String, token: String) {
            self.email = email
            self.token = token
        }
    }

    @Published
    private(set) var credential: Credential?

    let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.credential = defaults.credential(for: "auth")
    }

    func login(_ credential: Credential) {
        self.credential = credential
        self.defaults.set(credential, for: "auth")
    }

    func logout() {
        credential = nil
        defaults.set(nil, for: "auth")
    }

}

private extension UserDefaults {

    func set(_ credential: Session.Credential?, for key: String) {
        if let credential = credential {
            let value = try? JSONEncoder().encode(credential)
            set(value, forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    func credential(for key: String) -> Session.Credential? {
        guard let value = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(Session.Credential.self, from: value)
    }

}
