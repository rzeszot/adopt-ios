//
//  SwipeViewController.swift
//  Adopt
//
//  Created by Damian Rzeszot on 02/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import SwiftUI

class SwipeViewController: UIViewController, DeckViewDataSource, DeckViewDelegate {

    // MARK: -

    var deckView: DeckView!

    // MARK: -

    override func loadView() {
        deckView = DeckView()
        deckView.dataSource = self
        deckView.delegate = self

        view = deckView
        view.backgroundColor = .blue
    }

    // MARK: - DeckViewDataSource

    var cards: [String] = [
        "Raven",
        "Red",
        "Ms Glandular",
        "Rumaisa",
        "Miss Humblefoot",
        "Licorice",
        "Ms Mild",
        "Silhouette"
    ]

    func numberOfCards(in deckView: DeckView) -> Int {
        cards.count
    }

    func deckView(_ deckView: DeckView, viewForCardAt index: Int) -> UIView {
        let label = UILabel()
        label.text = cards[index]
        label.backgroundColor = .red
        return label
    }

    // MARK: - DeckViewDelegate

    func deckView(_ deckView: DeckView, didSelectViewAt index: Int) {
        print("select \(index)")
    }

}

struct SwipeWrapper: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<SwipeWrapper>) -> SwipeViewController {
        let vc = SwipeViewController()
        return vc
    }

    func updateUIViewController(_ vc: SwipeViewController, context: UIViewControllerRepresentableContext<SwipeWrapper>) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    struct Coordinator {

    }
}
