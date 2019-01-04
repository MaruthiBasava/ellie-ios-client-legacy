////
////  EllieSectionCreateFirstPage.swift
////  Ellie
////
////  Created by Mar Basava on 4/11/17.
////  Copyright © 2017 MarBasava. All rights reserved.
////
//
//import UIKit
//import EasyPeasy
//
//class EllieSectionCreateFirstPage: UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        headerTextField.delegate = self
//        colorPickerView.delegate = self
//        colorPickerView.layoutDelegate = self
//        
//        headerTextField.delegate = self
//        headerTextField.text = sectionPreview.sectionLabel.text?.capitalized
//        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow),
//                                               name: .UIKeyboardWillShow,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide),
//                                               name: .UIKeyboardWillHide,
//                                               object: nil)
//        
//        sectionPreview.sectionLabel.font.withSize(14)
//    }
//    
//    func initializeLayouts() {
//        addSubview(sectionPreview)
//        addSubview(textFieldTitle)
//        addSubview(headerTextField)
//        addSubview(colorPickerTitle)
//        addSubview(colorPickerView)
//        addSubview(nextPageButton)
//        
//        sectionPreview.easy.layout(
//            Center(0.0),
//            Top(10).to(popviewTitle),
//            Width(sectionPreview.size.width * 1.3),
//            Height(sectionPreview.size.height * 1.3)
//)
//        
//        textFieldTitle.easy.layout(
//            Center(0.0),
//            Top(15).to(sectionPreview),
//            Left(15)
//)
//        
//        headerTextField.easy.layout(
//            Center(0.0),
//            Top(10).to(textFieldTitle),
//            Width(276),
//            Height(40)
//)
//        
//        colorPickerTitle.easy.layout(
//            Center(0.0),
//            Top(10).to(headerTextField),
//            Left(15)
//)
//        
//        colorPickerView.easy.layout(
//            Center(0.0),
//            Left(15),
//            Right(15),
//            Top(0).to(colorPickerTitle),
//            Height(60)
//)
//        
//        nextPageButton.easy.layout(
//            Center(0.0),
//            Bottom(20),
//            Width(120),
//            Height(45)
//)
//
//        sectionPreview.initializeLayouts()
//    }
//    
//    func nextSelection() {
//        fadeOut()
//        closeTextField(textField: headerTextField)
//        
//        secondPage.fadeIn()
//    }
//
//    var secondPage : UIView!
//    var popviewTitle : UILabel!
//    
//    lazy var sectionPreview : EllieSectionPreviewView = {
//        let section = EllieSectionPreviewView()
//        section.applyBiggerFont()
//        return section
//    }()
//
//    lazy var textFieldTitle : UILabel = {
//        let label = UILabel()
//        let b = "section"
//        let a = "Name your \(b)."
//        label.applyEllieLabelProperties(a: a, b: b, starting: 10)
//        label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 17)
//        label.textAlignment = .center
//        label.textColor = UIColor.EllieColors.flatDarkGreen
//        
//        return label
//    }()
//    
//    lazy var headerTextField : UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = UIColor.white
//        textField.borderStyle = .none
//        
//        textField.layer.cornerRadius = 0
//        textField.layer.shadowColor = UIColor.black.cgColor
//        textField.layer.shadowOpacity = 0.25
//        textField.layer.shadowRadius = 3
//        textField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
//        textField.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 16)
//        textField.textColor = UIColor.EllieColors.flatDarkGreen
//        textField.textAlignment = .center
//        
//        return textField
//    }()
//    
//    lazy var colorPickerTitle : UILabel = {
//        let label = UILabel()
//        let b = "color"
//        let a = "Pick your \(b)."
//        label.applyEllieLabelProperties(a: a, b: b, starting: 10)
//        label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 17)
//        label.textAlignment = .center
//        label.textColor = UIColor.EllieColors.flatDarkGreen
//        
//        return label
//    }()
//    
//    lazy var colorPickerView : ColorPickerView = {
//        let colorPicker = ColorPickerView()
//        colorPicker.style = .circle
//        colorPicker.selectionStyle = .check
//        return colorPicker
//    }()
//
//    lazy var nextPageButton : EllieCornerRoundedUIButton = {
//        let button = EllieCornerRoundedUIButton()
//        
//        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
//        button.titleLabel?.textColor = UIColor.white
//        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
//        
//        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor
//        button.layer.cornerRadius = 3
//        button.setTitle("Next", for: .normal)
//        
//        
//        button.addTarget(self, action: #selector(nextSelection), for: .touchUpInside)
//        
//        
//        return button
//    }()
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//extension EllieSectionCreateFirstPage : UITextFieldDelegate, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
//    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
//            else { return }
//        
//        guard headerTextField.isEditing
//            else { return }
//        
//        window?.frame.origin.y = -1 * keyboardSize.height
//        
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        
//        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
//            else { return }
//        
//        guard window?.frame.origin.y != 0
//            else { return }
//        
//        window?.frame.origin.y += keyboardSize.height
//        
//        
//    }
//    
//    func closeTextField(textField: UITextField) {
//       
//        sectionPreview.updateSectionLabel(string: textField.text!)
//        
//        textField.resignFirstResponder()
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
//        closeTextField(textField: textField)
//        return true
//    }
//    
//    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
//        // A color has been selected
//        let color = colorPickerView.colors[indexPath.row]
//        sectionPreview.backgroundColor = color
//        sectionPreview.layer.shadowColor = color.cgColor
//    }
//    
//    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // The size for each cell
//        // 👉🏻 WIDTH AND HEIGHT MUST BE EQUALS!
//        
//        return CGSize(width: 32, height: 32)
//    }
//    
//    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        // Space between cells
//        return 12
//    }
//    
//}
