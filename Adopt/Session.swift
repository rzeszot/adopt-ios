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

    struct User {

    }

    var user: User? {
        if token == nil {
            return nil
        } else {
            return User()
        }
    }

    func login(_ data: SignIn.Data) {
        token = data.token
    }

    func logout() {
        token = nil
    }

}
