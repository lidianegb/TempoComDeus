//
//  NotesTransitionDelegates.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 11/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit
extension NotesViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
            guard let toViewController = transitionContext.viewController(forKey: .to),
                let fromViewController = transitionContext.viewController(forKey: .from) else {
                    return
            }

            if isPresenting {
                containerView.addSubview(toViewController.view)
                toViewController.view.alpha = 0
                UIView.animate(withDuration: 0.4, animations: {
                    toViewController.view.alpha = 1
                }, completion: { _ in
                    transitionContext.completeTransition(true)
                })
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    fromViewController.view.alpha = 0
                }, completion: { _ in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                })
            }
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
        
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }

}
