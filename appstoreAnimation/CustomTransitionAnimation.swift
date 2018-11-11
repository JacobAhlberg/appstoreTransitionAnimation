//
//  TransitionManager.swift
//  appstoreAnimation
//
//  Created by Jacob Ahlberg on 2018-11-10.
//  Copyright © 2018 Jacob Ahlberg. All rights reserved.
//

import UIKit

protocol Animatable {
    var containerView: UIView? { get }
    var childView: UIView? { get }
    
    func presentingView(sizeAnimator: UIViewPropertyAnimator,
                        positionAnimator: UIViewPropertyAnimator,
                        fromFrame: CGRect,
                        toFrame: CGRect)
    
    func dismissingView(sizeAnimator: UIViewPropertyAnimator,
                        positionAnimator: UIViewPropertyAnimator,
                        fromFrame: CGRect,
                        toFrame: CGRect)
}

extension Animatable {
    func presentingView(sizeAnimator: UIViewPropertyAnimator,
                        positionAnimator: UIViewPropertyAnimator,
                        fromFrame: CGRect,
                        toFrame: CGRect) {}
    
    func dismissingView(sizeAnimator: UIViewPropertyAnimator,
                        positionAnimator: UIViewPropertyAnimator,
                        fromFrame: CGRect,
                        toFrame: CGRect) {}
}

class CustomTransitionAnimation: NSObject {
    fileprivate let operationType: UINavigationController.Operation
    fileprivate let positioningDuration: TimeInterval
    fileprivate let resizingDuration: TimeInterval
    
    init(operation: UINavigationController.Operation, positioningDuration: TimeInterval, resizingDuration: TimeInterval) {
        self.operationType = operation
        self.positioningDuration = positioningDuration
        self.resizingDuration = resizingDuration
    }
    
}

extension CustomTransitionAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return max(self.resizingDuration, self.positioningDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if operationType == .push {
            self.presentTransition(transitionContext)
        } else if operationType == .pop {
            self.dismissTransition(transitionContext)
        }
    }
}

extension CustomTransitionAnimation {
    internal func presentTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? Animatable,
            let fromContainer = fromVC.containerView,
            let fromChild = fromVC.childView else {
            return
        }
        
        guard let toVC = transitionContext.viewController(forKey: .to) as? Animatable,
            let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        
        let originFrame = CGRect(
            origin: fromContainer.convert(fromChild.frame.origin, to: container),
            size: fromChild.frame.size
        )
        
        let destinationFrame = toView.frame
        
        toView.frame = originFrame
        toView.layoutIfNeeded()
        
        fromChild.isHidden = true
        
        let yDiff = destinationFrame.origin.y - originFrame.origin.y
        let xDiff = destinationFrame.origin.x - originFrame.origin.x
        
        let positionAnimator = UIViewPropertyAnimator(duration: self.positioningDuration, dampingRatio: 0.7)
        positionAnimator.addAnimations {
            // Move the view in the Y direction
            toView.transform = CGAffineTransform(translationX: 0, y: yDiff)
        }
        
        let sizeAnimator = UIViewPropertyAnimator(duration: self.resizingDuration, curve: .easeInOut)
        sizeAnimator.addAnimations {
            // Animate the size of the detailVC
            toView.frame.size = destinationFrame.size
            toView.layoutIfNeeded()
            
            // Move the view in the X direction.
            toView.transform = toView.transform.concatenating(CGAffineTransform(translationX: xDiff, y: 0))
        }
        
        toVC.presentingView(
            sizeAnimator: sizeAnimator,
            positionAnimator: positionAnimator,
            fromFrame: originFrame,
            toFrame: destinationFrame
        )
        
        
        container.addSubview(toView)
        
    }
    
    internal func dismissTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
}

