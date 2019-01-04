//
//  EllieCreateSectionModalView.swift
//  Ellie
//
//  Created by Mar Basava on 7/12/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieCreateSectionModalView: EllieScrollableModalView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle(title: "CREATE SECTION")
        sectionPreview.updateSectionLabel(string: "VALENCE ELECTRON")
        
        sectionTextField.delegate = self
        sectionTextField1.delegate = self
        sectionTextField2.delegate = self

        sectionTextField.text = sectionPreview.sectionLabel.text?.capitalized
        
    }
    
    override func initializeLayouts() {
        super.initializeLayouts()
        
        addSubview(sectionPreview)
        addSubview(sectionPreview1)
        addSubview(sectionPreview2)
        addSubview(sectionPreview3)
        addSubview(sectionPreview4)
        addSubview(sectionPreview5)
        addSubview(sectionPreview6)

//        addSubview(sectionTitleLabel)
//        addSubview(sectionTextField)
//        addSubview(sectionTextField1)
//        addSubview(sectionTextField2)
//
//        
        sectionPreview.easy.layout(
            Center(0.0),
            Size(sectionPreview.viewSize),
            Top(40).to(popviewTitle)
)
        
        sectionPreview1.easy.layout(
            Center(0.0),
            Size(sectionPreview.viewSize),
            Top(40).to(sectionPreview)
)
        
        sectionPreview2.easy.layout(
            Center(0.0),
            Size(sectionPreview.viewSize),
            Top(40).to(sectionPreview1)
)
        
        sectionPreview3.easy.layout(
            Center(0.0),
            Size(sectionPreview.viewSize),
            Top(40).to(sectionPreview2)
)
        
        sectionPreview4.easy.layout(
            Center(0.0),
            Size(sectionPreview.viewSize),
            Top(40).to(sectionPreview3)
)
        
        sectionPreview5.easy.layout(
            Center(0.0),
            Size(sectionPreview.viewSize),
            Top(40).to(sectionPreview4)
)
        
        sectionPreview6.easy.layout(
            Center(0.0),
            Size(sectionPreview.viewSize),
            Top(40).to(sectionPreview5)
)
//
//                sectionTitleLabel.easy.layout(
//                    Center(0.0),
//                    Top(40).to(sectionPreview),
//                    Left(15)
//        )
//        
//                sectionTextField.easy.layout(
//                    Center(0.0),
//                    Top(10).to(sectionTitleLabel),
//                    Left(15),
//                    Right(15),
//                    Height(40)
//        )
//        
//        sectionTextField1.easy.layout(
//            Center(0.0),
//            Top(10).to(sectionTextField),
//            Left(15),
//            Right(15),
//            Height(40)
//)
//        
//        sectionTextField2.easy.layout(
//            Center(0.0),
//            Top(10).to(sectionTextField1),
//            Left(15),
//            Right(15),
//            Height(40)
//)

        
    }
    
    var sectionPreview = EllieSectionPreviewView()
    var sectionPreview1 = EllieSectionPreviewView()
    var sectionPreview2 = EllieSectionPreviewView()
    var sectionPreview3 = EllieSectionPreviewView()
    var sectionPreview4 = EllieSectionPreviewView()
    var sectionPreview5 = EllieSectionPreviewView()
    var sectionPreview6 = EllieSectionPreviewView()

        lazy var sectionTitleLabel : UILabel = {
            let label = UILabel()
            let b = "section"
            let a = "Name your \(b)."
            label.applyEllieLabelProperties(a: a, b: b, starting: 10)
            label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 17)
            label.textAlignment = .center
            label.textColor = UIColor.EllieColors.flatDarkGreen
    
            return label
        }()
    
        lazy var sectionTextField : UITextField = {
            let textField = UITextField()
            textField.backgroundColor = UIColor.white
            textField.borderStyle = .none
    
            textField.layer.cornerRadius = 0
            textField.layer.shadowColor = UIColor.EllieColors.flatShadowGray.cgColor
            textField.layer.shadowOpacity = 1
            textField.layer.shadowRadius = 2
            textField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
            textField.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 16)
            textField.textColor = UIColor.EllieColors.flatDarkGreen
            textField.textAlignment = .center
            textField.returnKeyType = .done
            
            return textField
        }()
    
    lazy var sectionTextField1 : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .none
        
        textField.layer.cornerRadius = 0
        textField.layer.shadowColor = UIColor.EllieColors.flatShadowGray.cgColor
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        textField.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 16)
        textField.textColor = UIColor.EllieColors.flatDarkGreen
        textField.textAlignment = .center
        textField.returnKeyType = .done
        
        return textField
    }()
    lazy var sectionTextField2 : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .none
        
        textField.layer.cornerRadius = 0
        textField.layer.shadowColor = UIColor.EllieColors.flatShadowGray.cgColor
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        textField.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 16)
        textField.textColor = UIColor.EllieColors.flatDarkGreen
        textField.textAlignment = .center
        textField.returnKeyType = .done
        
        return textField
    }()


    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension EllieCreateSectionModalView : UITextFieldDelegate {
            
        func closeTextField(textField: UITextField) {

            if !(textField.text?.isEmpty)! {
                sectionPreview.updateSectionLabel(string: textField.text!)
            }
            
            textField.resignFirstResponder()
        }
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
            closeTextField(textField: textField)
            return true
        }
}
