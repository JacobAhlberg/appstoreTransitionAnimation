//
//  Cell.swift
//  appstoreAnimation
//
//  Created by Jacob Ahlberg on 2018-11-10.
//  Copyright © 2018 Jacob Ahlberg. All rights reserved.
//

import UIKit


class CardCell: UICollectionViewCell {
    @IBOutlet weak var commonView: CommonView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonView.layer.cornerRadius = 10
        commonView.layer.masksToBounds = true
    }
}
