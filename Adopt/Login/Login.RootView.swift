//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Login {

    struct RootView: View {
        var action: (Coordinator.Output) -> Void

        var body: some View {
            Wrapper(login: { output in
                print("output \(output)")

                self.action(output)
            })
        }
    }

}

struct Login_RootView_Previews: PreviewProvider {
    static var previews: some View {
        Login.RootView(action: { _ in })
    }
}
