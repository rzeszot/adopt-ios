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
        var dismiss: () -> Void

        @State
        var code: Bool = false

        var body: some View {
            if code {
                return AnyView(CodeView())
            } else {
                return AnyView(EmailView(back: dismiss))
            }
        }
    }
}

struct Forget_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Forget.RootView(dismiss: {})
    }
}
