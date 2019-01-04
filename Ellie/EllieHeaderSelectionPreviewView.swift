//
//  EllieHeaderSelectionPreviewView.swift
//  Ellie
//
//  Created by Mar Basava on 4/11/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieHeaderSelectionPreviewView: EllieRoundedView {

    
    var viewSize = CGSize(width: 139, height: 35)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.EllieColors.flatDarkGreen
        layer.cornerRadius = 17
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        
       addSubview(sectionLabel)
        
        sectionLabel.easy.layout(Center(0.0))
        
    }

    lazy var sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 12)
        label.textAlignment = .center
        label.textColor = UIColor.white
//        label.addCharactersSpacing(spacing: EllieConstants.labelSpacing , text: "UNSECTIONED")
        
        return label
    }()

}
