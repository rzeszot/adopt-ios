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

    enum Direction {
        case left
        case right
    }

    enum State {
        case snapping
        case moving
        case swiping
    }

    // MARK: - State

    var item: UIDynamicItem
    var state: State

    // MARK: -

    var snap: UISnapBehavior!
    var attachment: UIAttachmentBehavior!
    var push: UIPushBehavior!

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

    // MARK: - Push

    func push(from point: CGPoint, to direction: CGVector) {
        push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.pushDirection = direction

        addChildBehavior(push)
    }

    func unpush() {
        guard push != nil else { return }

        removeChildBehavior(push)
        push = nil
    }

}


//class StickyCornersBehavior: UIDynamicBehavior {
//    // MARK: Properties
//
//    private var cornerInset: CGFloat
//
//    private let itemBehavior: UIDynamicItemBehavior
//
//    private let collisionBehavior: UICollisionBehavior
//
//    private let item: UIDynamicItem
//
//    private var fieldBehaviors = [UIFieldBehavior]()
//
//    // Enabling/disabling effectively adds or removes the item from the child behaviors.
//    var isEnabled = true {
//        didSet {
//            if isEnabled {
//                for fieldBehavior in fieldBehaviors {
//                    fieldBehavior.addItem(item)
//                }
//                collisionBehavior.addItem(item)
//                itemBehavior.addItem(item)
//            }
//            else {
//                for fieldBehavior in fieldBehaviors {
//                    fieldBehavior.removeItem(item)
//                }
//                collisionBehavior.removeItem(item)
//                itemBehavior.removeItem(item)
//            }
//        }
//    }
//
//    var currentCorner: StickyCorner? {
//        guard dynamicAnimator != nil else { return nil }
//
//        let position = item.center
//        for (i, fieldBehavior) in fieldBehaviors.enumerated() {
//            let fieldPosition = fieldBehavior.position
//            let location = CGPoint(x: position.x - fieldPosition.x, y: position.y - fieldPosition.y)
//
//            if fieldBehavior.region.contains(location) {
//                // Force unwrap the result because we know we have an actual corner at this point.
//                let corner = StickyCorner(rawValue: i)!
//
//                return corner
//            }
//        }
//
//        return nil
//    }
//
//    // MARK: Initializers
//
//    init(item: UIDynamicItem, cornerInset: CGFloat) {
//        self.item = item
//        self.cornerInset = cornerInset
//
//        // Setup a collision behavior so the item cannot escape the screen.
//        collisionBehavior = UICollisionBehavior(items: [item])
//        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
//
//        // Setup the item behavior to alter the items physical properties causing it to be "sticky."
//        itemBehavior = UIDynamicItemBehavior(items: [item])
//        itemBehavior.density = 0.01
//        itemBehavior.resistance = 10
//        itemBehavior.friction = 0.0
//        itemBehavior.allowsRotation = false
//
//        super.init()
//
//        // Add each behavior as a child behavior.
//        addChildBehavior(collisionBehavior)
//        addChildBehavior(itemBehavior)
//
//        /*
//            Setup a spring field behavior, one for each quadrant of the screen.
//            Then add each as a child behavior.
//        */
//        for _ in 0...3 {
//            let fieldBehavior = UIFieldBehavior.springField()
//            fieldBehavior.addItem(item)
//            fieldBehaviors.append(fieldBehavior)
//            addChildBehavior(fieldBehavior)
//        }
//    }
//
//    // MARK: UIDynamicBehavior
//
//    override func willMove(to dynamicAnimator: UIDynamicAnimator?) {
//        super.willMove(to: dynamicAnimator)
//
//        guard let bounds = dynamicAnimator?.referenceView?.bounds else { return }
//
//        updateFieldsInBounds(bounds: bounds)
//    }
//
//    // MARK: Public
//
//    func updateFieldsInBounds(bounds: CGRect) {
//        if bounds != CGRect.zero {
//            let itemBounds = item.bounds
//
//            /*
//                Determine the horizontal & vertical adjustment required to satisfy
//                the cornerInset given the itemBounds.
//            */
//            let dx = cornerInset + itemBounds.width / 2.0
//            let dy = cornerInset + itemBounds.height / 2.0
//
//            // Get bounds width & height.
//            let h = bounds.height
//            let w = bounds.width
//
//            // Private function to update the position & region of a given field.
//            func updateRegionForField(field: UIFieldBehavior, _ point: CGPoint) {
//                field.position = point
//                field.region = UIRegion(size: CGSize(width: w - (dx * 2), height: h - (dy * 2)))
//            }
//
//            // Calculate the field origins.
//            let topLeft = CGPoint(x: dx, y: dy)
//            let bottomLeft = CGPoint(x: dx, y: h - dy)
//            let bottomRight = CGPoint(x: w - dx, y: h - dy)
//            let topRight = CGPoint(x: w - dx, y: dy)
//
//            // Update each field.
//            updateRegionForField(field: fieldBehaviors[StickyCorner.TopLeft.rawValue], topLeft)
//            updateRegionForField(field: fieldBehaviors[StickyCorner.BottomLeft.rawValue], bottomLeft)
//            updateRegionForField(field: fieldBehaviors[StickyCorner.BottomRight.rawValue], bottomRight)
//            updateRegionForField(field: fieldBehaviors[StickyCorner.TopRight.rawValue], topRight)
//        }
//    }
//
//    func addLinearVelocity(velocity: CGPoint) {
//        itemBehavior.addLinearVelocity(velocity, for: item)
//    }
//
//    func positionForCorner(corner: StickyCorner) -> CGPoint {
//        return fieldBehaviors[corner.rawValue].position
//    }
//}





//
//class CardBehaviour: UIDynamicBehavior {
//
//    // MARK: - Types
//
//    enum Direction {
//        case left
//        case right
//    }
//
//    enum State {
//        case snapping
//        case moving
//        case swiping
//    }
//
//    // MARK: - State
//
//    var item: UIDynamicItem
//    var state: State
//
//    // MARK: -
//
//    var snap: UISnapBehavior!
//    var attachment: UIAttachmentBehavior!
//    var push: UIPushBehavior!
//
//    // MARK: -
//
//    init(item: UIDynamicItem) {
//        self.item = item
//        state = .snapping
//    }
//
//    // MARK: - Snap
//
//    func snap(to point: CGPoint) {
//        guard snap == nil else { return }
//
//        snap = UISnapBehavior(item: item, snapTo: point)
//        snap.damping = 0.75
//
//        addChildBehavior(snap)
//    }
//
//    func unsnap() {
//        guard snap != nil else { return }
//
//        removeChildBehavior(snap)
//        snap = nil
//    }
//
//    // MARK: - Attachment
//
//    func attach(to point: CGPoint, offset: UIOffset) {
//        attachment = UIAttachmentBehavior(item: item, offsetFromCenter: offset, attachedToAnchor: point)
//
//        addChildBehavior(attachment)
//    }
//
//    func deattach() {
//        guard attachment != nil else { return }
//
//        removeChildBehavior(attachment)
//        attachment = nil
//    }
//
//    func move(to point: CGPoint) {
//        attachment.anchorPoint = point
//    }
//
//    // MARK: - Push
//
//    func push(from point: CGPoint, to direction: CGVector) {
//        push = UIPushBehavior(items: [item], mode: .instantaneous)
//        push.pushDirection = direction
//
//        addChildBehavior(push)
//    }
//
//    func unpush() {
//        guard push != nil else { return }
//
//        removeChildBehavior(push)
//        push = nil
//    }
//
//}
///*
//    Copyright (C) 2015 Apple Inc. All Rights Reserved.
//    See LICENSE.txt for this sample’s licensing information
//
//    Abstract:
//    StickyCornersBehavior is a compound UIDynamicBehavior subclass that causes the asscoiated item to stick to one of the corners of the reference system.
//*/
//
//import UIKit
//
//enum StickyCorner: Int {
//    case TopLeft = 0
//    case BottomLeft
//    case BottomRight
//    case TopRight
//}
//
