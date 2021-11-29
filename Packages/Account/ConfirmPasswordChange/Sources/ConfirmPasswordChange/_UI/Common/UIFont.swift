import UIKit

extension UIFont {
  open func withWeight(_ fontWeight: UIFont.Weight) -> UIFont {
    let newDescriptor = fontDescriptor.addingAttributes([
      .traits: [
        UIFontDescriptor.TraitKey.weight: fontWeight
      ]
    ])

    return UIFont(descriptor: newDescriptor, size: pointSize)
  }
}
