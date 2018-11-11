//
//  CommonView.swift
//  appstoreAnimation
//
//  Created by Jacob Ahlberg on 2018-11-11.
//  Copyright © 2018 Jacob Ahlberg. All rights reserved.
//

import UIKit

class CommonView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("CommonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
