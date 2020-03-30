//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDataSource {

    // MARK: - Outlets

    @IBOutlet
    var favouriteButton: UIButton!

    // MARK: - Actions

    @IBAction
    func favouriteAction() {
        favouriteButton.isSelected = !favouriteButton.isSelected
    }

    @IBAction
    func shareAction() {
        let url: URL = "https://adopt.rzeszot.pro/animal/12345"
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = favouriteButton
        vc.completionWithItemsHandler = { type, completed, returned, error in
            print("\(String(describing: type)), \(completed), \(String(describing: returned)), \(String(describing: error))")
        }

        present(vc, animated: true)
    }

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Marley"
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }

}
