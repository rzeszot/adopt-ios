//
//  Adopt
//
//  Created by Damian Rzeszot on 01/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Welcome {

    struct IntroView: View {
        
        // MARK: -

        var action: (Modal) -> Void

        // MARK: -

        var body: some View {
            VStack(spacing: 10) {
                Spacer()

                LogoView()

                Spacer()
                
                ActionButton(action: {
                    self.action(.login)
                }, text: {
                    Text("Log In to Existing Account")
                        .font(Font.custom("Montserrat-SemiBold", size: 16))
                        .foregroundColor(Color(.systemBackground))
                }, color: Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))

                ActionButton(action: {
                    self.action(.register)
                }, text: {
                    Text("Create New Account")
                        .foregroundColor(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
                })
            }
            .padding(.horizontal, 20)
        }
    }
    
    struct ActionButton: View {
        var action: () -> Void
        var text: () -> Text
        var color: Color? = nil

        var body: some View {
            Button(action: action, label: {
                HStack {
                    Spacer()
                    text()
                    Spacer()
                }
                .padding(20)
                .background(color ?? .clear)
                .cornerRadius(10)
            })
        }
    }
    
    struct LogoView: View {
        var body: some View {
            HStack(alignment: .center, spacing: 0) {
                Image("paw")
                    .foregroundColor(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
                    .offset(x: -8, y: 0)

                Text("Adopt")
                    .font(Font.custom("offside-regular", size: 40))

                Text("!")
                    .font(Font.custom("offside-regular", size: 40))
                    .foregroundColor(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
            }
        }
    }

}

struct Welcome_IntroView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome.IntroView(action: { _ in })
    }
}
