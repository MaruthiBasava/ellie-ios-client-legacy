//
//  EllieCornerRoundedUIButton.swift
//  EllieApp
//
//  Created by Mar Basava on 12/30/16.
//  Copyright © 2016 MarBasava. All rights reserved.
//

import UIKit

class EllieCornerRoundedUIButton: UIButton {
    
    
    let SHADOW_OPACITY : Float = 0.25
    let SHADOW_RADIUS : CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 6.81
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = SHADOW_OPACITY
        layer.shadowRadius = SHADOW_RADIUS
        layer.shadowOffset = CGSize.init(width: 0, height: 2)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
