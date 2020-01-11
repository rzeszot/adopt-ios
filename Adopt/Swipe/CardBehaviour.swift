//
//  CardBehaviour.swift
//  Adopt
//
//  Created by Damian Rzeszot on 04/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class CardBehaviour: UIDynamicBehavior {

    // MARK: - Types

    enum State {
        case snapping
        case moving
        case swiping
    }

    // MARK: - State

    var item: UIDynamicItem
    var state: State

    // MARK: -

    private var snap: UISnapBehavior!
    private var attachment: UIAttachmentBehavior!

    // MARK: -

    init(item: UIDynamicItem) {
        self.item = item
        state = .snapping
    }

    // MARK: - Snap

    func snap(to point: CGPoint) {
        guard snap == nil else { return }

        snap = UISnapBehavior(item: item, snapTo: point)
        snap.damping = 0.75

        addChildBehavior(snap)
    }

    func unsnap() {
        guard snap != nil else { return }

        removeChildBehavior(snap)
        snap = nil
    }

    // MARK: - Attachment

    func attach(to point: CGPoint, offset: UIOffset) {
        attachment = UIAttachmentBehavior(item: item, offsetFromCenter: offset, attachedToAnchor: point)

        addChildBehavior(attachment)
    }

    func deattach() {
        guard attachment != nil else { return }

        removeChildBehavior(attachment)
        attachment = nil
    }

    func move(to point: CGPoint) {
        attachment.anchorPoint = point
    }

}
