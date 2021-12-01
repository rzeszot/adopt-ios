import SwiftUI

struct FeedView: View {
  struct Ocean: Identifiable {
    let name: String
    var id: String { name }
  }

  let oceans = [
    Ocean(name: "Pacific"),
    Ocean(name: "Atlantic"),
    Ocean(name: "Indian"),
    Ocean(name: "Southern"),
    Ocean(name: "Arctic")
  ]

  var body: some View {
    NavigationView {
      List(oceans) { ocean in
        NavigationLink(ocean.name) {
          DetailsView(ocean: ocean)
        }
      }
    }
  }

}
