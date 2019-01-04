//
//  EllieCloseablePopupView.swift
//  Wide
//
//  Created by Mar Basava on 4/9/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy
import SimpleAnimation

class EllieCloseablePopupView: UIView {
    
    var isClosed = true
    var isKeyboardPresent = false
    
    var firstKeyboardHeight : CGFloat = 0
    var firstKeyboardShown = false
    
    var height : CGFloat = 265
    
    lazy var popupView : EllieRoundedView = {
        let view = EllieRoundedView()
        return view
    }()
    
    lazy var shadowView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.EllieColors.flatMedimumBlack
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        return view
    }()
    
    lazy var closeButton : EllieImageButton = {
        let a = EllieImageButton()
        a.appendTarget(target: self, selector: #selector(close))
        return a
    }()
    
    lazy var popviewTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 17)
        label.textAlignment = .center
        label.textColor = UIColor.EllieColors.flatDarkGreen
        
        return label
    }()
    
    func setTitle(title: String) {
        //        popviewTitle.addCharactersSpacing(spacing: 3.5, text: title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.zPosition = 20
        hide()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        
        addSubview(shadowView)
        
        addSubview(popupView)
        popupView.addSubview(closeButton)
        popupView.addSubview(popviewTitle)
        
        shadowView.easy.layout(
            Edges(0)
)
        
        popupView.easy.layout(
            Center(0.0),
            Left(15),
            Right(15),
            Height(height)
)
        
        closeButton.easy.layout(
            Top(0),
            Right(0),
            Width(50),
            Height(50)
)
        
        popviewTitle.easy.layout(
            Center(0.0),
            Top(15)
)
        
    }
    
    func open() {
        if isClosed {
            DispatchQueue.main.async {
                [weak self] in
                self?.fadeIn()
                self?.popupView.slideIn(from: .top)
                self?.isClosed = false
            }
            
        }
    }
    
    
    func close() {
        if !isClosed {
            DispatchQueue.main.async {
                [weak self] in
                self?.popupView.slideOut(to: .bottom) {
                    done in
                    self?.fadeOut()
                    self?.isClosed = true
                }
                
            }
        }
    }
    
    func hide() {
        isHidden = true
    }
    
}
