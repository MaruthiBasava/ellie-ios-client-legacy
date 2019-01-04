//
//  WideRoundedView.swift
//  Wide
//
//  Created by Mar Basava on 3/29/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit

class WideRoundedView: UIView {
    
    let SHADOW_OPACITY : Float = 0.25
    let SHADOW_RADIUS : CGFloat = 3
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 6.81
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = SHADOW_OPACITY
        layer.shadowRadius = SHADOW_RADIUS
        layer.shadowOffset = CGSize.init(width: 0, height: 2)

    }
    
    
}
