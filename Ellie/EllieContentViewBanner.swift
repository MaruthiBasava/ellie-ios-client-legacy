//
//  EllieContentViewBanner.swift
//  Ellie
//
//  Created by Mar Basava on 9/4/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit

class EllieContentViewBanner: EllieViewControllerBanner {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        height = 23
        bannerLabel.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 12)
            
        super.initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 4.25)
    }
}
