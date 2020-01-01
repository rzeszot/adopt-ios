//
//  Session.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

class Session: ObservableObject {

    struct Credential {
        let token: String
    }

    @Published
    private(set) var token: String?

    func login(_ credential: Credential) {
        token = credential.token
    }

    func logout() {
        token = nil
    }


    class User: ObservableObject {
        let token: String

        init(token: String) {
            self.token = token
        }
    }

    var user: User? {
        return token.map { User(token: $0) }
    }

}
