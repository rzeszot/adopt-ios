//
//  Forget.RootView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 01/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Forget {
    struct RootView: View {
        var back: () -> Void

        var body: some View {
            VStack {
                Spacer()
                Text("Hello, World!")
                Spacer()
                Button(action: back, label: { Text("Back to Login") })
            }
        }
    }
}

struct Forget_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Forget.RootView(back: {})
    }
}
