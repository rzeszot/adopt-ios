//
//  Session.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

class Session: ObservableObject {

    class Credential: ObservableObject {
        let email: String
        let token: String

        init(email: String, token: String) {
            self.email = email
            self.token = token
        }
    }

    @Published
    private(set) var credential: Credential?

    func login(_ credential: Credential) {
        self.credential = credential
    }

    func logout() {
        credential = nil
    }

}
