//
//  EllieViewControllerBanner.swift
//  Ellie
//
//  Created by Mar Basava on 9/1/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class EllieViewControllerBanner : UIView {
    
    var height : CGFloat = 40
    
    lazy var bannerLabel : UILabel = {
        let a = UILabel()
        a.textAlignment = .center
        a.textColor = UIColor.white
        a.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 17)

        return a
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        layer.shadowRadius = 0
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        
        addSubview(bannerLabel)
        
        bannerLabel.easy.layout(
            Center(0.0)
)
        
    }

    
}
