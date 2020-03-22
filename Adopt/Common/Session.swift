//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

class Session {

    struct Credentials {
        let email: String
        let token: String
    }

    private(set) var credentials: Credentials?

    init(credentials: Credentials? = nil) {
        self.credentials = credentials
    }

    // MARK: -

    func login(_ credentials: Credentials) {
        self.credentials = credentials
    }

    func logout() {
        credentials = nil
    }

}
