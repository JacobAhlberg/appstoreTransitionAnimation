//
//  ShadowView.swift
//  appstoreAnimation
//
//  Created by Jacob Ahlberg on 2018-11-11.
//  Copyright © 2018 Jacob Ahlberg. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 20, height: 20)
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
    
    
}
