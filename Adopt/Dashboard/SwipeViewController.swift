//
//  SwipeViewController.swift
//  Adopt
//
//  Created by Damian Rzeszot on 02/01/2020.
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import SwiftUI

class SwipeViewController: UIViewController {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .blue
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
