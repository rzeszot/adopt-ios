//
//  Adopt
//
//  Created by Damian Rzeszot on 01/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import AVFoundation
import SwiftUI

extension Welcome {
    struct IntroView: View {
        var action: (Modal) -> Void

        var body: some View {
            VStack(spacing: 10) {
                Spacer()

                Text("Adopt!")
                    .font(Font.custom("offside-regular", size: 40))
                    .padding()

                    .cornerRadius(15.0)

                Spacer()

                Button(action: {
                    self.action(.login)
                }, label: {
                    HStack {
                        Spacer()
                        Text("Log In to Existing Account")
                            .foregroundColor(Color(.systemBackground))
                        Spacer()
                    }
                    .padding(14)
                    .background(Color.accentColor)
                    .cornerRadius(5)
                })

                Button(action: {
                    self.action(.register)
                }, label: {
                    HStack {
                        Spacer()
                        Text("Create New Account")
                        Spacer()
                    }
                    .padding(14)
                })
            }
            .padding(.horizontal, 20)
        }
    }
}

struct Welcome_IntroView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome.IntroView(action: { _ in })
    }
}
