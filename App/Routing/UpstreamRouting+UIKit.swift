import UIKit

extension UIViewController: UpstreamRouting {
  public var upstream: Routing? { parent }
}
