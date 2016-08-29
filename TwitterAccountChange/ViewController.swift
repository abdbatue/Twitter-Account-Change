//
//  ViewController.swift
//  TwitterAccountChange
//
//  Created by Batuhan Eker on 29.08.2016.
//  Copyright © 2016 Abdurrahman Eker. All rights reserved.
//

import UIKit

var toplamHesap = 10

class ViewController: UIViewController {
    
    private let presentAnimationController = PresentAnimationController()
    private let dismissAnimationController = DismissAnimationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor.grayColor()
        
        let button = UIButton()
        button.frame = CGRectMake(0, 150, self.view.bounds.width, 20)
        button.setTitle("Hesaplar", forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.openTableView), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    func openTableView() {
        let tableViewController = UINavigationController(rootViewController: TableViewController())
        
        tableViewController.transitioningDelegate = self

        presentAnimationController.wireToViewController(tableViewController)
        
        self.navigationController?.presentViewController(tableViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        presentAnimationController.modalY = (4*44)+44
        
        return presentAnimationController
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        dismissAnimationController.snapshot = presentAnimationController.snapshot
        
        return dismissAnimationController
        
    }
    
}

