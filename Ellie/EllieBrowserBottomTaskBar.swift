//
//  EllieBrowserBottomTaskBar.swift
//  Ellie
//
//  Created by Mar Basava on 9/3/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieBrowserBottomTaskBar: UIView {
    
    var height : CGFloat = 50
    
    fileprivate let buttonSize : CGFloat = 42
    
    lazy var downloadCurrentLinkButton : EllieImageButton = {
        let a = EllieImageButton()
        a.buttonImage.image = UIImage(named: WideImages.download)
        return a
    }()
    
    lazy var bookmarkButton : EllieImageButton = {
        let a = EllieImageButton()
        a.buttonImage.image = UIImage(named: WideImages.bookmark)
        return a
    }()
  
    lazy var goBackButton : EllieImageButton = {
        let a = EllieImageButton()
        a.buttonImage.image = UIImage(named: WideImages.rightCaret)
        return a
    }()
    
    lazy var goForwardButton : EllieImageButton = {
        let a = EllieImageButton()
        a.buttonImage.image = UIImage(named: WideImages.leftCaret)
        return a
    }()
    
    lazy var pullButton : EllieImageButton = {
        let a = EllieImageButton()
        a.buttonImage.image = UIImage(named: WideImages.topCaret)
        
        a.buttonImage.easy.layout(
            Top(10),
            Width(20),
            Height(20)
)
                
        return a
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 0
        layer.shadowRadius = 2
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(goBackButton)
        addSubview(goForwardButton)
        addSubview(downloadCurrentLinkButton)
        addSubview(bookmarkButton)
        addSubview(pullButton)
        
        goBackButton.easy.layout(
            Center(0.0),
            Left(5),
            Width(buttonSize),
            Height(buttonSize)
)
        
        goForwardButton.easy.layout(
            Center(0.0),
            Left(0).to(goBackButton),
            Width(buttonSize),
            Height(buttonSize)
)
        
        downloadCurrentLinkButton.easy.layout(
            Center(0.0),
            Right(5),
            Width(buttonSize),
            Height(buttonSize)
)
        
        bookmarkButton.easy.layout(
            Center(0.0),
            Right(0).to(downloadCurrentLinkButton),
            Width(buttonSize),
            Height(buttonSize)
)
    
        pullButton.easy.layout(
            Center(0.0),
            Top(0),
            Width(65),
            Height(50)
)
        
    }
    
}
