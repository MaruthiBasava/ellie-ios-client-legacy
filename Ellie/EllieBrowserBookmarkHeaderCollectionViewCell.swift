//
//  EllieBrowserBookmarkHeaderCollectionViewCell.swift
//  Ellie
//
//  Created by Mar Basava on 9/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieBrowserBookmarkHeaderCollectionViewCell: UICollectionViewCell {
    
    lazy var bookmarkHeader : UILabel = {
        var label = UILabel()
        label.font = UIFont(name: WideFonts.montserratRegular, size: 16)
        label.textColor = UIColor.EllieColors.flatDarkerMediumBlack
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shouldRasterize = true;
        layer.rasterizationScale = UIScreen.main.scale;
                
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(bookmarkHeader)
        bookmarkHeader.easy.layout(
            Center(0),
            Left(0),
            Right(0),
            Height(bounds.height)
)
        
    }
    
    
}
