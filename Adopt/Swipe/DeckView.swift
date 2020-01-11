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
    var contentInsets: UIEdgeInsets = .init(top: 50, left: 50, bottom: 150, right: 50)

    // MARK: -

    private var size: CGSize {
        let content = bounds.inset(by: contentInsets)
        return CGSize(side: min(content.width, content.height))
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

    private var attachment: UIAttachmentBehavior!
    private var snap: UISnapBehavior!

    @objc
    func panAction(_ recognizer: UIPanGestureRecognizer) {
        guard let subview = recognizer.view else { return }

        switch recognizer.state {
        case .began:
            let attachment = UIAttachmentBehavior(item: subview, attachedToAnchor: recognizer.location(in: self))
            animator.addBehavior(attachment)
            self.attachment = attachment

        case .changed:
            let location = recognizer.location(in: self)
            attachment.anchorPoint = location
            break

        case .ended, .cancelled, .failed:
            animator.removeBehavior(attachment)
            attachment = nil

        case .possible:
            break
        @unknown default:
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
