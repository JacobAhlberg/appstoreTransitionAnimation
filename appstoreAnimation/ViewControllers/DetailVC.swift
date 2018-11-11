//
//  DetailVC.swift
//  appstoreAnimation
//
//  Created by Jacob Ahlberg on 2018-11-10.
//  Copyright © 2018 Jacob Ahlberg. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    static func create() -> DetailVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        return vc
    }
    
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var commonView: CommonView!
    @IBOutlet weak var bodyView: UIView!
    
    @IBOutlet weak var commonViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var commonViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func asCard(_ value: Bool) {
        self.maskView.layer.cornerRadius = value ? 10 : 0
    }
    

}

extension DetailVC: Animatable {
    var containerView: UIView? {
        return self.view
    }
    
    var childView: UIView? {
        return self.commonView
    }
    
    func presentingView(sizeAnimator: UIViewPropertyAnimator, positionAnimator: UIViewPropertyAnimator, fromFrame: CGRect, toFrame: CGRect) {
        // Make the common view the same size as the initial frame
        self.commonViewHeightConstraint.constant = fromFrame.height
        
        // Show the close button
        self.closeBtn.alpha = 1
        
        // Make the view look like a card
        self.asCard(true)
        
        // Redraw the view to update the previous changes
        self.view.layoutIfNeeded()
        
        // Animate the common view to a height of 500 points
        self.commonViewHeightConstraint.constant = 500
        sizeAnimator.addAnimations {
            self.view.layoutIfNeeded()
        }
        
        // Animate the view to not look like a card
        positionAnimator.addAnimations {
            self.asCard(false)
        }
        
    }
    
    func dismissingView(sizeAnimator: UIViewPropertyAnimator, positionAnimator: UIViewPropertyAnimator, fromFrame: CGRect, toFrame: CGRect) {
        // If the user has scrolled down in the content, force the common view to go to the top of the screen.
        self.commonViewTopConstraint.isActive = true
        
        // If the top card is completely off screen, we move it to be JUST off screen.
        // This makes for a cleaner looking animation.
        if scrollView.contentOffset.y > commonView.frame.height {
            self.commonViewTopConstraint.constant = -commonView.frame.height
            self.view.layoutIfNeeded()
            
            // Still want to animate the common view getting pinned to the top of the view
            self.commonViewTopConstraint.constant = 0
        }
        
        // Animate the height of the common view to be the same size as the TO frame.
        // Also animate hiding the close button
        self.commonViewHeightConstraint.constant = toFrame.height
        sizeAnimator.addAnimations {
            self.closeBtn.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        // Animate the view to look like a card
        positionAnimator.addAnimations {
            self.asCard(true)
        }
        
    }
    
}
