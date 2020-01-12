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
                
                HStack(alignment: .center, spacing: 5) {
                    Image("paw")
                        .foregroundColor(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
                
                    Text("Adopt!")
                        .font(Font.custom("offside-regular", size: 40))
                }

                Spacer()

                Button(action: {
                    self.action(.login)
                }, label: {
                    HStack {
                        Spacer()
                        Text("Log In to Existing Account")
                            .font(Font.custom("Montserrat-SemiBold", size: 16))
                            .foregroundColor(Color(.systemBackground))
                        Spacer()
                    }
                    .padding(20)
                    .background(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
                    .cornerRadius(10)
                })

                Button(action: {
                    self.action(.register)
                }, label: {
                    HStack {
                        Spacer()
                        Text("Create New Account")
                            .foregroundColor(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
                        Spacer()
                    }
                    .padding(20)
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
