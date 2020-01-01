//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Login {

    struct RootView: View {
        var finish: (Output) -> Void
        var move: (Coordinator.Target) -> Void

        var service: Service = .init()

        var body: some View {
            Wrapper(perform: perform, move: move)
                .edgesIgnoringSafeArea(.all)
        }

        func perform(_ input: Service.Input) {
            service.perform(input) { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.finish(Output(email: input.email, token: success.token))
                    }
                    break
                case .failure:
                    print("failure")
                    break
                }
            }
        }
    }
}

struct Login_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Login.RootView(finish: { _ in }, move: { _ in })
    }
}
