//
//  EllieImageButton.swift
//  Ellie
//
//  Created by Mar Basava on 4/13/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class EllieImageButton : UIButton {
    
    let SHADOW_OPACITY : Float = 0.25
    let SHADOW_RADIUS : CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeLayouts()
        
    }
    
    func initializeLayouts() {
        addSubview(buttonImage)
        
        buttonImage.easy.layout(
            Center(0.0),
            Width(15),
            Height(15))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var buttonImage : UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: WideImages.closeimageView)
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFit
        
        return image
        
    }()
    
    func convertToCircle(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.EllieColors.flatShadowGray.cgColor
        layer.shadowOpacity = SHADOW_OPACITY
        layer.shadowRadius = SHADOW_RADIUS
        layer.shadowOffset = CGSize.init(width: 0, height: 0)
    }
    
    func appendTarget(target: Any?, selector: Selector) {

        addTarget(target, action: selector, for: .touchUpInside)
        buttonImage.addGestureRecognizer(
            UITapGestureRecognizer(target: target, action: selector)
        )
        
    }
    
}
