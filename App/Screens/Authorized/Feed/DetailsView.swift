import SwiftUI

struct DetailsView: View {
  let ocean: FeedView.Ocean

  var body: some View {
    VStack {
      Spacer()
      Text(ocean.name)
      Spacer()
      Divider()
    }
  }
}
