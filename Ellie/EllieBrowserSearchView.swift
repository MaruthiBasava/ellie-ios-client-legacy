//
//  EllieBrowserSearchView.swift
//  Ellie
//
//  Created by Mar Basava on 9/1/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

protocol EllieBroswerSearchViewDelegate : class {
    func search(query: String)
    func home()
    func refresh()
}

class EllieBrowserSearchView : EllieRoundedView, UITextFieldDelegate {
    
    var height : CGFloat = 50
    
    weak var delegate : EllieBroswerSearchViewDelegate?
    
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
        addSubview(homeButton)
        addSubview(searchField)
        searchField.addSubview(refreshButton)
        addSubview(progress)
        
        homeButton.easy.layout(
            Center(0.0),
            Left(5),
            Width(35),
            Height(35))
        
        searchField.easy.layout(
            Center(0.0),
            Right(10),
            Left(5).to(homeButton),
            Height(30))
        
        refreshButton.easy.layout(
            Center(0.0),
            Right(5),
            Width(25),
            Height(25))
        
        refreshButton.buttonImage.easy.layout(
            Width(12),
            Height(12))
        
        progress.easy.layout(
            Bottom(0),
            Left(0),
            Right(0))
        
        
        searchField.setLeftPaddingPoints(10)
        searchField.setRightPaddingPoints(25)
        
        
        postLayoutInitialization()
    }
    
    func postLayoutInitialization() {
        searchField.clearButtonRect(forBounds: CGRect(x: 0, y: 5, width: 10, height: 10))
    }
    
    func goHome() {
         guard delegate != nil else { return }
        delegate?.home()
    }
    
    func refreshNow() {
         guard delegate != nil else { return }
         delegate?.refresh()
    }
    
    lazy var homeButton : EllieImageButton = {
        let a = EllieImageButton()
        
        a.appendTarget(target: self, selector: #selector(goHome))
        
        return a
    }()
    
    lazy var searchField : UITextField = {
        let a = UITextField()
        a.backgroundColor = UIColor.EllieColors.flatGray
        a.layer.cornerRadius = 15
        a.font = UIFont(name: WideFonts.josefinSansRegular, size: 15)
        a.textColor = UIColor.EllieColors.flatMedimumBlack
        a.textAlignment = .center
        a.autocapitalizationType = .none
        a.keyboardType = .webSearch
        a.returnKeyType = .search
        a.delegate = self
        a.placeholder = "Enter a url or any keywords"
        a.clearButtonMode = .always
        return a
    }()
    
    lazy var refreshButton : EllieImageButton = {
        let a = EllieImageButton()
        a.buttonImage.image = UIImage(named: WideImages.refresh)
        a.appendTarget(target: self, selector: #selector(refreshNow))
        return a
    }()
    
    lazy var progress: UIProgressView = {
        let a = UIProgressView()
        a.progressTintColor = UIColor.EllieColors.flatDarkGreen
        a.trackTintColor = UIColor.EllieColors.flatGray
        a.setProgress(0.0, animated: false)
        return a
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .search {
            guard delegate != nil else { return false }
            delegate?.search(query: textField.text!)
        }
        
        textField.endEditing(true)
        
        return true;
    }
    
}
