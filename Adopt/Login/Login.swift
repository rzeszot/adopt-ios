//
//  Login.swift
//  Adopt
//
//  Created by Damian Rzeszot on 01/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

struct Login {
    enum Modal: String, Identifiable {
        case forget
    }
    
    struct Output {
        let email: String
        let token: String
    }
}
