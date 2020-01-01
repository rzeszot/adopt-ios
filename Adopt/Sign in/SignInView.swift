//
//  SignInView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    var action: (Coordinator.Output) -> Void

    var body: some View {
        Wrapper(login: { output in
            print("output \(output)")

            self.action(output)
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(action: { _ in })
    }
}
