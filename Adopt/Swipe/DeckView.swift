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

    // MARK: - Attributes helpers

    private var count: Int {
        dataSource?.numberOfCards(in: self) ?? 0
    }

    private func view(at index: Int) -> UIView {
        dataSource!.deckView(self, viewForCardAt: index)
    }

    // MARK: - Inspectables

    @IBInspectable
    var contentInsets: UIEdgeInsets = .init(top: 100, left: 100, bottom: 150, right: 100)

    // MARK: -

    private var workspace: CGRect {
        bounds.inset(by: contentInsets)
    }

    private var size: CGSize {
        CGSize(side: min(workspace.width, workspace.height))
    }

    private var left: CGPoint {
        center.offsetBy(dx: -size.width - 20, dy: 0)
    }

    private var right: CGPoint {
        center.offsetBy(dx: size.width + 20, dy: 0)
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
