//
//  ModalPresentAnimationController.swift
//  TwitterAccountChange
//
//  Created by Batuhan Eker on 29.08.2016.
//  Copyright © 2016 Abdurrahman Eker. All rights reserved.
//

import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var snapshot: UIView!
    var modalY: CGFloat!
    private weak var viewController: UIViewController!
    private var toVC: UIViewController!
    
    func wireToViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.75
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
        let containerView = transitionContext.containerView() else {
                return
        }
        
        toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let finalFrame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        snapshot = fromVC.view.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = finalFrame
        containerView.addSubview(snapshot)
        
        let closeModalTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PresentAnimationController.closeModal))
        snapshot.addGestureRecognizer(closeModalTap)
        
        toVC.view.frame = CGRectMake(0, finalFrame.height, finalFrame.width, finalFrame.height)
        containerView.addSubview(toVC.view)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(PresentAnimationController.handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(PresentAnimationController.handleSwipes(_:)))
        
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        
        containerView.addGestureRecognizer(upSwipe)
        containerView.addGestureRecognizer(downSwipe)
        
        fromVC.view.hidden = true
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration-0.3) {
            self.snapshot.layer.opacity = 0.75
            self.snapshot.layer.transform = CATransform3DMakeScale(0.94, 0.94, 1)
        }
        
        UIView.animateWithDuration(duration, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.toVC.view.frame = CGRectMake(0, finalFrame.height-self.modalY, finalFrame.width, finalFrame.height)
            
            }) { (finished) in
                fromVC.view.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
       
    }
    
    func closeModal() {
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func handleSwipes(gesture: UISwipeGestureRecognizer) {
        if (gesture.direction == .Up) {
            UIApplication.sharedApplication().statusBarStyle = .Default

            UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
                
                self.toVC.view.frame = CGRectMake(0, 0, self.toVC.view.frame.width, self.toVC.view.frame.height)
                UIApplication.sharedApplication().statusBarHidden = true
                UIApplication.sharedApplication().statusBarHidden = false
                
            }, completion: nil)
            
            NSNotificationCenter.defaultCenter().postNotificationName("active", object: nil)
        }
        
        if (gesture.direction == .Down) {
            closeModal()
        }
    }
    
}
