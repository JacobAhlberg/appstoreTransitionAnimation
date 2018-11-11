//
//  NavigationController.swift
//  appstoreAnimation
//
//  Created by Jacob Ahlberg on 2018-11-11.
//  Copyright © 2018 Jacob Ahlberg. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimation(operation: operation, positioningDuration: 1, resizingDuration: 0.5)
    }
}
