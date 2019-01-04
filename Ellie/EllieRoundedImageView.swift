//
//  EllieRoundedImageView.swift
//  Ellie
//
//  Created by Mar Basava on 9/4/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit

class EllieRoundedImageView: UIImageView {

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
