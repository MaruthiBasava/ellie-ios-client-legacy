//
//  EllieSectionPreviewView.swift
//  Wide
//
//  Created by Mar Basava on 4/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieSectionPreviewView: EllieRoundedView {
    
    var viewSize = CGSize(width: 130*1.20 , height: 180*1.20 )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = sectionDataModel.backgroundColor
        layer.shadowColor = UIColor.white.cgColor
        
        updateSectionLabel(string: sectionDataModel.sectionTitle)
        
        initializeLayouts()
    }
    
    func initializeLayouts() {
        addSubview(sectionLabel)
        
        sectionLabel.easy.layout(
            Center(0.0),
            Left(5),
            Right(5)
)
        
    }
    
    func updateSectionLabel(string: String) {
        _ = string.replacingOccurrences(of: " ",
                                            with: "\n")
    
//        sectionLabel.addCharactersSpacing(spacing: EllieConstants.labelSpacing,
//                                          text: b.uppercased())
        sectionDataModel.sectionTitle = string
    }
    
    func updateBackgroundColor(color: UIColor) {
        backgroundColor = color
        
        sectionDataModel.backgroundColor = color
    }
    
    var sectionDataModel = EllieSectionDataModel()
    
    lazy var sectionLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 15)
        
        return label
    }()
    
    func applySmallerFont() {
        sectionLabel.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 10)
    }
    
    func applyBiggerFont() {
        sectionLabel.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 14)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
