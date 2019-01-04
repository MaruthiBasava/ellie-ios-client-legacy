//
//  EllieBrowserBookmarkPreview.swift
//  Ellie
//
//  Created by Mar Basava on 9/16/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import EasyPeasy
import UIImageViewAlignedSwift

class EllieBrowserBookmarkPreview : UIView {
    
    lazy var foundationalView : EllieRoundedView = {
        let a = EllieRoundedView()
        return a
    }()
    
    lazy var bookmarkScreenShot : UIImageViewAligned = {
        [weak self] in
        let a = UIImageViewAligned()
        a.contentMode = .scaleAspectFill
        a.alignTop = true
        a.clipsToBounds = true
        a.layer.cornerRadius = 4.25
        return a
    }()

    lazy var bookmarkedWebsiteTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.ralewayRegular, size: 9)
        label.text = "BOOKMARK"
        label.addCharactersSpacing(spacing: EllieConstants.labelSpacing0p69)
        label.textColor = UIColor.EllieColors.flatDarkerMediumBlack
        label.textAlignment = .center
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
//        bookmarkScreenShot.roundCorners(corners: [.allCorners], radius: 4.25)
    }
    
    func reset() {
        bookmarkedWebsiteTitle.text = "BOOKMARK"
        bookmarkScreenShot.image = nil
    }

    func initializeLayouts() {
        addSubview(foundationalView)
        foundationalView.addSubview(bookmarkScreenShot)
        addSubview(bookmarkedWebsiteTitle)
        
        foundationalView.easy.layout(
            Center(0.0),
            Top(10),
            Width(85),
            Height(85))
        
        bookmarkScreenShot.easy.layout(Edges(0))
     
        bookmarkedWebsiteTitle.easy.layout(
            Center(0.0),
            Top(5).to(bookmarkScreenShot),
            Width().like(bookmarkScreenShot))
    }

}
