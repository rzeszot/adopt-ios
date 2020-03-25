//
//
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import Foundation

class Session {

    struct Credential {
        let email: String
        let token: String
    }

    class Guest {
        func login(_ credential: Credential) -> User {
            return User(credential: credential)
        }
    }

    class User {
        let credential: Credential

        init(credential: Credential) {
            self.credential = credential
        }

        func logout() -> Guest {
            return Guest()
        }
    }

}
