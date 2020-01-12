//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Login {

    struct RootView: View {

        // MARK: -

        @EnvironmentObject
        var service: Service

        var dismiss: () -> Void
        var finish: (Output) -> Void

        // MARK: -
        
        @State
        private var modal: Modal?
        
        // MARK: -

        var body: some View {
            Wrapper(perform: perform, dismiss: dismiss, forget: { self.modal = .forget })
                .edgesIgnoringSafeArea(.all)
                .sheet(item: $modal, content: subview)
        }

        // MARK: -

        var forget: some View {
            Forget.RootView(dismiss: { self.modal = nil })
        }
        
        func subview(for modal: Modal) -> some View {
            forget
        }

        // MARK: -

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
                }
            }
        }
    }

}

struct Login_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Login.RootView(dismiss: {}, finish: { _ in })
    }
}
