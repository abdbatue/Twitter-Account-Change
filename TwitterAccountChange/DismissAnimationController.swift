//
//  ModalDismissAnimationController.swift
//  TwitterAccountChange
//
//  Created by Batuhan Eker on 29.08.2016.
//  Copyright © 2016 Abdurrahman Eker. All rights reserved.
//

import UIKit

class DismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var snapshot: UIView!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.75
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
        let finalFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        toVC.view.hidden = true
        toVC.view.frame = finalFrame
        containerView.addSubview(toVC.view)
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration-0.3) {
            self.snapshot.layer.opacity = 1
            self.snapshot.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
            
            fromVC.view.frame = CGRectMake(0, finalFrame.height, finalFrame.width, finalFrame.height)
            
        }) { (finished) in
            self.snapshot.removeFromSuperview()
            toVC.view.hidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
}
