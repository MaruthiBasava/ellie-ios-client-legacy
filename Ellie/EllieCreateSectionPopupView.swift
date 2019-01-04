//
//  EllieCreateSectionPopupView.swift
//  Wide
//
//  Created by Mar Basava on 4/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieCreateSectionPopupView: EllieCloseablePopupView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        popviewTitle.addCharactersSpacing(spacing: 4.29, text: "CREATE SECTION")
    
    }
    
    override func initializeLayouts() {
        super.initializeLayouts()
    
    }
    
    var navigationController : UINavigationController!
    
    var windowSize = CGSize(width: 300, height: 500)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
