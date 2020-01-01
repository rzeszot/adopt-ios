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

        var body: some View {
            Wrapper(login: finish, move: move)
                .edgesIgnoringSafeArea(.all)
        }
    }

}

struct Login_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Login.RootView(finish: { _ in }, move: { _ in })
    }
}
