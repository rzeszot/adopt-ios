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
                        .foregroundColor(Color.white)
                }, color: Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))

                ActionButton(action: {
                    self.action(.register)
                }, text: {
                    Text("Create New Account")
                        .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                })
            }
            .padding(.horizontal, 20)
            .background(Color.white)
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
//        LinearGradient(
//            gradient: Gradient(colors: [.red, .white]),
//            startPoint: .top,
//            endPoint: .bottom
//        )
    }
    
    struct LogoView: View {
        var body: some View {
            HStack(alignment: .center, spacing: 0) {
                Image("paw")
                    .foregroundColor(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
                    .offset(x: -8, y: 0)

                Text("A")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6823529412, blue: 0.937254902, alpha: 1)))
                Text("d")
                    .foregroundColor(Color(#colorLiteral(red: 0.9450980392, green: 0.6980392157, blue: 0.1137254902, alpha: 1)))
                Text("o")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6823529412, blue: 0.937254902, alpha: 1)))
                Text("p")
                    .foregroundColor(Color(#colorLiteral(red: 0.9450980392, green: 0.6980392157, blue: 0.1137254902, alpha: 1)))
                Text("t")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6823529412, blue: 0.937254902, alpha: 1)))

                Text("!")
                    .foregroundColor(Color(#colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)))
            }
            .font(Font.custom("offside-regular", size: 40))
        }
    }

}

struct Welcome_IntroView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome.IntroView(action: { _ in })
    }
}
