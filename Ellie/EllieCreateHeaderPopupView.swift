//
//  EllieCreateHeaderPopupView.swift
//  Wide
//
//  Created by Mar Basava on 4/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieCreateHeaderPopupView: EllieCloseablePopupView, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        popviewTitle.addCharactersSpacing(spacing: 4.29, text: "CREATE HEADER")
        createHeaderButton.setTitle("Create Header", for: .normal)
        headerTextField.delegate = self
        
    }
    
    override func initializeLayouts() {
        super.initializeLayouts()
        
        
        addSubview(textFieldTitle)
        addSubview(headerTextField)
        addSubview(createHeaderButton)
        
        textFieldTitle.easy.layout(
            Center(0.0),
            Top(30).to(popviewTitle),
            Left(15))
        
        headerTextField.easy.layout(
            Center(0.0),
            Top(10).to(textFieldTitle),
            Width(276),
            Height(40))
        
        createHeaderButton.easy.layout(
            Center(0.0),
            Top(20).to(headerTextField),
            Bottom(20),
            Width(190),
            Height(45))
        
    }
    
    func createHeader() {
        popOut()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        headerTextField.resignFirstResponder()
        return true
    }
    
    
    var windowSize = CGSize(width: 300, height: 250)
    
    lazy var textFieldTitle : UILabel = {
        let label = UILabel()
        let b = "header"
        let a = "Name your \(b)."
        label.applyEllieLabelProperties(a: a, b: b, starting: 10)
        label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 17)
        label.textAlignment = .center
        label.textColor = UIColor.EllieColors.flatDarkGreen
        
        return label
    }()
    
    lazy var headerTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .none
        
        textField.layer.cornerRadius = 0
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.25
        textField.layer.shadowRadius = 3
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        textField.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 16)
        textField.textColor = UIColor.EllieColors.flatDarkGreen
        textField.textAlignment = .center
        
        return textField
    }()
    
    lazy var createHeaderButton : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
        
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
        
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor
        button.layer.cornerRadius = 3
        
        
        button.addTarget(self, action: #selector(createHeader), for: .touchUpInside)
        
        
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
