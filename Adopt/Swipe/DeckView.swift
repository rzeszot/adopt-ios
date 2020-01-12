//
//  DeckView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 04/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class DeckView: UIView {

    weak var dataSource: DeckViewDataSource? {
        didSet {
            reloadData()
        }
    }

    weak var delegate: DeckViewDelegate? {
        didSet {
            reloadData()
        }
    }

    // MARK: - Data Source helpers

    private var count: Int {
        dataSource?.numberOfCards(in: self) ?? 0
    }

    private func view(at index: Int) -> UIView {
        dataSource!.deckView(self, viewForCardAt: index)
    }

    // MARK: - Inspectables

    @IBInspectable
    var contentInsets: UIEdgeInsets = .init(top: 150, left: 150, bottom: 150, right: 150)

    // MARK: -

    private var workspace: CGRect {
        bounds.inset(by: contentInsets)
    }

    private var size: CGSize {
        CGSize(side: min(workspace.width, workspace.height))
    }

    private var left: CGPoint {
        center.offsetBy(dx: -(bounds.width + size.width)/2 + 50, dy: 0)
    }

    private var right: CGPoint {
        center.offsetBy(dx: (bounds.width + size.width)/2 - 50, dy: 0)
    }

    // MARK: -

    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
    private var arrangedSubviews: [UIView] = []
    private var subviewsIndexMapping: [UIView: Int] = [:]

    func addArrangedSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.isUserInteractionEnabled = true
        subview.transform = .identity

        arrangedSubviews.append(subview)
        addSubview(subview)

        addSizeConstraints(for: subview)
        addPositionConstraints(for: subview)
    }

    func addSizeConstraints(for subview: UIView) {
        subview.widthAnchor.constraint(equalToConstant: size.width).set(identifier: "width").set(active: true)
        subview.heightAnchor.constraint(equalToConstant: size.height).set(identifier: "height").set(active: true)
    }

    func addPositionConstraints(for subview: UIView) {
        subview.centerXAnchor.constraint(equalTo: centerXAnchor).set(active: true)
        subview.centerYAnchor.constraint(equalTo: centerYAnchor).set(active: true)
    }

    func updatePositionConstraints(for subview: UIView) {

    }

    func updateSizeConstraints(for subview: UIView) {
        subview.constraints.first(where: { $0.identifier == "width" })?.constant = size.width
        subview.constraints.first(where: { $0.identifier == "height" })?.constant = size.height
    }

    // MARK: - Actions

    var behaviour: CardBehaviour!

    @objc
    func panAction(_ recognizer: UIPanGestureRecognizer) {
        guard let subview = recognizer.view else { return }

        if behaviour == nil {
            behaviour = CardBehaviour(item: subview)
            animator.addBehavior(behaviour)
        }

        let location = recognizer.location(in: self)

        switch recognizer.state {
        case .began:
            guard case .snapping = behaviour.state else { return }

            let point = recognizer.location(in: subview)
            let offset = UIOffset(horizontal: point.x - subview.bounds.midX, vertical: point.y - subview.bounds.midY)

            behaviour.state = .moving
            behaviour.unsnap()
            behaviour.attach(to: location, offset: offset)

        case .changed:
            guard case .moving = behaviour.state else { return }

            behaviour.state = .moving
            behaviour.move(to: location)

        case .ended, .cancelled, .failed:
            guard case .moving = behaviour.state else { return }

            let translation = recognizer.translation(in: self)
            let velocity = recognizer.velocity(in: self)

            if translation.x.sign == velocity.x.sign && (velocity.x > 750 || abs(translation.x) > bounds.width * 0.18) {
                let vector = CGVector(point: translation.normalized * max(velocity.x, 750))

                behaviour.state = .swiping
                behaviour.push(from: location, to: vector)
                behaviour.deattach()

                behaviour.push.action = {
                    guard self.animator.items(in: self.bounds).isEmpty else { return }
                    print("done")

                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.behaviour.state = .snapping
                        self.behaviour.unpush()
                        self.behaviour.deattach()
                        self.behaviour.snap(to: self.center)
                    }
                }
            } else {
                behaviour.state = .snapping
                behaviour.snap(to: center)
                behaviour.deattach()
            }
        default:
            break
        }
    }

    @objc
    func tapAction(_ recognizer: UITapGestureRecognizer) {
        guard let view = recognizer.view,
            let index = subviewsIndexMapping[view] else { return }

        delegate?.deckView(self, didSelectViewAt: index)
    }

    // MARK: -

    func reloadData() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }

        let subview = view(at: 0)
        addArrangedSubview(subview)

        subviewsIndexMapping[subview] = 0

        subview.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panAction(_:))))
        subview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction(_:))))
    }

    // MARK: - Overrides

    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)

        arrangedSubviews.removeAll(where: { $0 === subview })
        subviewsIndexMapping[subview] = nil
    }

    override func updateConstraints() {
        for subview in arrangedSubviews {
            updateSizeConstraints(for: subview)
            updatePositionConstraints(for: subview)
        }

        super.updateConstraints()
    }

    #if DEBUG
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.saveGState()

        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.stroke(workspace)

        ctx.setStrokeColor(UIColor.yellow.cgColor)
        ctx.stroke(CGRect(origin: left.offsetBy(dx: -size.width/2, dy: -size.height/2), size: size))
        ctx.stroke(CGRect(origin: right.offsetBy(dx: -size.width/2, dy: -size.height/2), size: size))

        ctx.setStrokeColor(UIColor.green.cgColor)
        ctx.stroke(CGRect(origin: center.offsetBy(dx: -size.width/2, dy: -size.height/2), size: size))

        ctx.setStrokeColor(UIColor.purple.cgColor)
        ctx.strokeLineSegments(between: [CGPoint(x: 0.18 * bounds.width, y: 0), CGPoint(x: 0.18 * bounds.width, y: bounds.height)])
        ctx.strokeLineSegments(between: [CGPoint(x: (1-0.18) * bounds.width, y: 0), CGPoint(x: (1-0.18) * bounds.width, y: bounds.height)])

        ctx.restoreGState()
    }
    #endif

}

extension CGSize {
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func set(identifier: String?) -> NSLayoutConstraint {
        self.identifier = identifier
        return self
    }

    @discardableResult
    func set(active: Bool) -> NSLayoutConstraint {
        self.isActive = active
        return self
    }
}

extension CGPoint {
    var magnitude: CGFloat {
        sqrt(pow(x, 2) + pow(y, 2))
    }

    var normalized: CGPoint {
        CGPoint(x: x / magnitude, y: y / magnitude)
    }

    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        CGPoint(x: x + dx, y: y + dy)
    }
}

extension CGVector {
    init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }
}

func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}


//
//
//    // MARK: -
//
//        lazy var animator: UIDynamicAnimator =
//        {
//            let dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
//            return dynamicAnimator
//        }()
//
//        lazy var collision: UICollisionBehavior =
//        {
//            let collision = UICollisionBehavior(items: [self.orangeView])
//            collision.translatesReferenceBoundsIntoBoundary = true
//            return collision
//        }()
//
//        lazy var fieldBehaviors: [UIFieldBehavior] =
//        {
//            var fieldBehaviors = [UIFieldBehavior]()
//            for _ in 0 ..< 2
//            {
//                let field = UIFieldBehavior.springField()
//                field.addItem(self.orangeView)
//                fieldBehaviors.append(field)
//            }
//            return fieldBehaviors
//        }()
//
//        lazy var itemBehavior: UIDynamicItemBehavior =
//        {
//            let itemBehavior = UIDynamicItemBehavior(items: [self.orangeView])
//            // Adjust these values to change the "stickiness" of the view
//            itemBehavior.density = 0.01
//            itemBehavior.resistance = 10
//            itemBehavior.friction = 0.0
//            itemBehavior.allowsRotation = false
//            return itemBehavior
//        }()
//
//        lazy var orangeView: UIView =
//        {
//            let widthHeight: CGFloat = 40.0
//            let orangeView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: widthHeight, height: widthHeight))
//            orangeView.backgroundColor = UIColor.orange
//            self.view.addSubview(orangeView)
//            return orangeView
//        }()
//
//        lazy var panGesture: UIPanGestureRecognizer =
//        {
//            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
//            return panGesture
//        }()
//
//        lazy var attachment: UIAttachmentBehavior =
//        {
//            let attachment = UIAttachmentBehavior(item: self.orangeView, attachedToAnchor: .zero)
//            return attachment
//        }()
//
//        override func viewDidLoad()
//        {
//            super.viewDidLoad()
//            animator.addBehavior(collision)
//            animator.addBehavior(itemBehavior)
//            for field in fieldBehaviors
//            {
//                animator.addBehavior(field)
//            }
//
//            orangeView.addGestureRecognizer(panGesture)
//        }
//
//        override func viewDidLayoutSubviews()
//        {
//            super.viewDidLayoutSubviews()
//
//            orangeView.center = view.center
//            animator.updateItem(usingCurrentState: orangeView)
//
//            for (index, field) in fieldBehaviors.enumerated()
//            {
//                field.position = CGPoint(x: view.bounds
//                    .midX, y:  view.bounds.height * (0.25 + 0.5 * CGFloat(index)))
//                field.region = UIRegion(size: CGSize(width: view.bounds.width, height: view.bounds.height * 0.5))
//            }
//        }
//
//    @objc func handlePan(sender: UIPanGestureRecognizer)
//        {
//            let location = sender.location(in: view)
//            let velocity = sender.velocity(in: view)
//            switch sender.state
//            {
//            case .began:
//                attachment.anchorPoint = location
//                animator.addBehavior(attachment)
//            case .changed:
//                attachment.anchorPoint = location
//            case .cancelled, .ended, .failed, .possible:
//                itemBehavior.addLinearVelocity(velocity, for: self.orangeView)
//                animator.removeBehavior(attachment)
//            default:
//                break
//            }
//        }
////    }
