//
//  RoundedView.swift
//  EllieApp
//
//  Created by Mar Basava on 12/30/16.
//  Copyright © 2016 MarBasava. All rights reserved.
//

import UIKit

class EllieRoundedView: UIView {
    
    var SHADOW_OPACITY : Float = 1
    var SHADOW_RADIUS : CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 4.25
        layer.shadowColor = UIColor.EllieColors.flatShadowGray.cgColor
        layer.shadowOpacity = SHADOW_OPACITY
        layer.shadowRadius = SHADOW_RADIUS
        layer.shadowOffset = CGSize.init(width: 0, height: 0)
        backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
