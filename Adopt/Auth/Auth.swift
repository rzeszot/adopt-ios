//
//  Adopt
//
//  Created by Damian Rzeszot on 01/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

struct Auth {
    enum Modal: String, Identifiable {
        case forget
        case register
    }
    
    struct Output {
        let email: String
        let token: String
    }
}
