//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import SwiftUI

extension Forget {
    struct EmailView: View {
        var back: () -> Void

        var body: some View {
            VStack {
                Spacer()
                Text("Fill email to reset")
                Spacer()
                Button(action: back, label: { Text("Back to Login") })
            }
        }
    }
}

struct Forget_EmailView_Previews: PreviewProvider {
    static var previews: some View {
        Forget.EmailView(back: {})
    }
}
