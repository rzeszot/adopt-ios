//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Forget {
    struct RootView: View {
        var dismiss: () -> Void

        @State
        var code: Bool = false

        var body: some View {
            VStack {
                HStack {
                    Text("xxx")
                    Text("yyy")
                }

                Spacer()

                Text("aaa")

                Spacer()

                Button(action: {}, label: {
                    Text("xxx")
                        .padding(20)
                        .foregroundColor(Color.white)
                })
                .background(Color.red)
            }

//            if code {
//                return AnyView(CodeView())
//            } else {
//                return AnyView(EmailView(back: dismiss))
//            }
        }
    }
}

struct Forget_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Forget.RootView(dismiss: {})
    }
}
