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
        self.commonViewHeightConstraint.constant = fromFrame.height
        
        self.closeBtn.alpha = 1
        
        self.asCard(true)
        
        self.view.layoutIfNeeded()
        
        self.commonViewHeightConstraint.constant = 500
        sizeAnimator.addAnimations {
            self.view.layoutIfNeeded()
        }
        
        positionAnimator.addAnimations {
            self.asCard(false)
        }
        
    }
    
    func dismissingView(sizeAnimator: UIViewPropertyAnimator, positionAnimator: UIViewPropertyAnimator, fromFrame: CGRect, toFrame: CGRect) {
        
    }
    
}
