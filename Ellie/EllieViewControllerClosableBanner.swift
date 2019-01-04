//
//  EllieViewControllerClosableBanner.swift
//  Ellie
//
//  Created by Mar Basava on 9/1/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

protocol EllieViewControllerClosableBannerDelegate : class {
    func closeView()
}

class EllieViewControllerClosableBanner : EllieViewControllerBanner {
    
    var isClosed = false

    weak var delegate : EllieViewControllerClosableBannerDelegate?
    
    lazy var closeButton : EllieImageButton = {
        let button = EllieImageButton()
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initializeLayouts() {
        super.initializeLayouts()
        
        addSubview(closeButton)
        
        closeButton.easy.layout(
            Center(0.0),
            Right(5),
            Width(40),
            Height(40)
)
        
    }
    
    func closeView() {
        if delegate != nil {
            isClosed = true
            delegate?.closeView()
        }
    }
    
    
    
}
