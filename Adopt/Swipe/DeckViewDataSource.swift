//
//  DeckViewDataSource.swift
//  Adopt
//
//  Created by Damian Rzeszot on 04/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

protocol DeckViewDataSource: class {
    func numberOfCards(in deckView: DeckView) -> Int
    func deckView(_ deckView: DeckView, viewForCardAt index: Int) -> UIView
}

protocol DeckViewDelegate: class {
    func deckView(_ deckView: DeckView, didSelectViewAt index: Int)
}

