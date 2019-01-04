//
//  EllieTopbar.swift
//  Ellie
//
//  Created by Mar Basava on 4/12/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieTopbar: EllieRoundedView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 0
        layer.shadowOffset = CGSize.init(width: 0, height: 2)
        
    }
    
    func initializeLayouts() {
        addSubview(controllerLabel)
        
        controllerLabel.easy.layout(
            Center(0.0),
            Bottom(10)
)
        
    }
    
    var height = CGFloat(88)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var controllerLabel : UILabel = {
        let label = UILabel()
//        label.addCharactersSpacing(spacing: 4.54, text: "AP CHEM TEST GUIDE")
        label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 16)
        label.textAlignment = .center
        label.textColor = UIColor.EllieColors.flatDarkGreen
        
        return label
    }()

}
