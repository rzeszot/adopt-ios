//
//  Session.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

class Session: ObservableObject {

    @Published
    private(set) var token: String?

    class User: ObservableObject {
        let token: String

        init(token: String) {
            self.token = token
        }
    }

    var user: User? {
        return token.map { User(token: $0) }
    }

    func login(_ data: SignIn.Data) {
        token = data.token
    }

    func logout() {
        token = nil
    }

}
