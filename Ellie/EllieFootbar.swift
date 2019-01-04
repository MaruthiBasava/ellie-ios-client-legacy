//
//  EllieFootbar.swift
//  Ellie
//
//  Created by Mar Basava on 4/12/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieFootbar: EllieRoundedView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 0
        layer.shadowOffset = CGSize.init(width: 0, height: -2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var height = CGFloat(70)
    
    lazy var a : EllieImageButton = {
        let button = EllieImageButton()
        return button
    }()
    
    lazy var b : EllieImageButton = {
        let button = EllieImageButton()
        return button
    }()
    
    lazy var c : EllieImageButton = {
        let button = EllieImageButton()
        return button
    }()
    
    lazy var d : EllieImageButton = {
        let button = EllieImageButton()
        return button
    }()
    
    lazy var e : EllieImageButton = {
        let button = EllieImageButton()
        return button
    }()
    
    
    func initializeLayouts() {
        addSubview(a)
        addSubview(b)
        addSubview(c)
        addSubview(d)
        addSubview(e)
        
        a.easy.layout(
            Center(0.0),
            Width(60),
            Height(60)
)

        b.easy.layout(
            Center(0.0),
            Right(2.5).to(a),
            Width(60),
            Height(60)
)
        
        c.easy.layout(
            Center(0.0),
            Right(2.5).to(b),
            Width(60),
            Height(60)
)
        
        d.easy.layout(
            Center(0.0),
            Left(2.5).to(a),
            Width(60),
            Height(60)
)
        
        e.easy.layout(
            Center(0.0),
            Left(2.5).to(d),
            Width(60),
            Height(60)
)
        
    }
    
}
