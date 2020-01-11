//
//  CardBehaviour.swift
//  Adopt
//
//  Created by Damian Rzeszot on 04/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class CardBehaviour: UIDynamicBehavior {

    private let item: UIDynamicItem
    private let snap: UISnapBehavior

    init(item: UIDynamicItem, snapTo point: CGPoint) {
        self.item = item
        self.snap = UISnapBehavior(item: item, snapTo: point)

        super.init()

        addChildBehavior(snap)
    }

}
