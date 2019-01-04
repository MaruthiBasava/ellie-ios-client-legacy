//
//  EllieCreateBookmarkPopupView.swift
//  Ellie
//
//  Created by Mar Basava on 9/12/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift
import EasyPeasy

protocol EllieBrowserBookmarkPreviewDelegate : class {
    
    func sendBookmarkModelData( bookmarkModel : EllieBookmarkModel )
    
}

class EllieCreateBookmarkPopupView: EllieCloseablePopupView {
    
    var bookmarkPreviewView = EllieBrowserBookmarkPreview()
    
    lazy var bookmarkTextfieldLabel : UILabel = {
        let label = UILabel()
        let b = "bookmark"
        let a = "Name your \(b)."
        label.textColor = UIColor.EllieColors.flatDarkerMediumBlack
        label.applyEllieLabelProperties(a: a, b: b, starting: 10)
        label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 15)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var bookmarkTextfield : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.EllieColors.flatGray
        textField.borderStyle = .none
        
        textField.layer.cornerRadius = 0
        textField.layer.shadowColor = UIColor.EllieColors.flatShadowGray.cgColor
        textField.layer.shadowRadius = 3
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        textField.font = UIFont(name: WideFonts.josefinSansRegular, size: 11)
        textField.textColor = UIColor.EllieColors.flatDarkerMediumBlack
        textField.textAlignment = .center
        textField.delegate = self
        textField.placeholder = "ex: YOUTUBE"
        textField.autocapitalizationType = .allCharacters
        textField.tag = 0
        textField.returnKeyType = .done
        
        return textField
    }()
    
    lazy var bookmarkUrlLabel : UILabel = {
        let label = UILabel()
        let b = "url"
        let a = "Edit your \(b)."
        label.textColor = UIColor.EllieColors.flatDarkerMediumBlack
        label.applyEllieLabelProperties(a: a, b: b, starting: 10)
        label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 15)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var bookmarkUrlTextfield : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.EllieColors.flatGray
        textField.borderStyle = .none
        
        textField.layer.cornerRadius = 0
        textField.layer.shadowColor = UIColor.EllieColors.flatShadowGray.cgColor
        textField.layer.shadowRadius = 3
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        textField.font = UIFont(name: WideFonts.josefinSansRegular, size: 11)
        textField.textColor = UIColor.EllieColors.flatDarkerMediumBlack
        textField.textAlignment = .center
        textField.delegate = self
        textField.placeholder = "ex: www.youtube.com"
        textField.autocapitalizationType = .allCharacters
        textField.keyboardType = .URL
        textField.returnKeyType = .done
        textField.tag = 1
        
        return textField
    }()
    
    lazy var createBookmarkButton : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
        button.setTitle("CREATE", for: .normal)
        
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 12)
        button.titleLabel?.addCharactersSpacing(spacing: EllieConstants.labelSpacing2p24)
        
        
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor
        button.layer.cornerRadius = 2
        
        button.addTarget(self, action: #selector(sendBookmarkModelData), for: .touchUpInside)
        
        
        return button
    }()
    
    weak var delegate : EllieBrowserBookmarkPreviewDelegate?
    
    var currentBookmarkURL = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        popviewTitle.text = "BOOKMARK"
        popviewTitle.addCharactersSpacing(spacing: EllieConstants.labelSpacing4p29)
        
        height = 400
        
        initializeLayouts()
    }
    
    func startObservation(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    func stopObservation() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initializeLayouts() {
        super.initializeLayouts()
        
        popupView.addSubview(bookmarkPreviewView)
        popupView.addSubview(bookmarkTextfieldLabel)
        popupView.addSubview(bookmarkTextfield)
        popupView.addSubview(bookmarkUrlLabel)
        popupView.addSubview(bookmarkUrlTextfield)
        popupView.addSubview(createBookmarkButton)
        
        bookmarkPreviewView.easy.layout(
            Center(0.0),
            Top(20).to(popviewTitle),
            Width(85),
            Height(120)
)
        
        bookmarkTextfieldLabel.easy.layout(
            Top(15).to(bookmarkPreviewView),
            Left(15),
            Right(15)
)
        
        bookmarkTextfield.easy.layout(
            Top(5).to(bookmarkTextfieldLabel),
            Left(15),
            Right(15),
            Height(32)
)
        
        bookmarkUrlLabel.easy.layout(
            Top(10).to(bookmarkTextfield),
            Left(15),
            Right(15)
)
        
        bookmarkUrlTextfield.easy.layout(
            Top(5).to(bookmarkUrlLabel),
            Left(15),
            Right(15),
            Height(50)
)
        
        createBookmarkButton.easy.layout(
            Center(0.0),
            Top(15).to(bookmarkUrlTextfield),
            Width(160),
            Height(40)
)
        
        //        bookmarkPreviewView.loadFavicon(bookmarkURL: currentBookmarkURL)
    }
    
    func reset() {
        bookmarkPreviewView.reset()
        bookmarkTextfield.text = ""
    }
    
    func validateDelegate() -> Bool {
        return delegate != nil
    }
    
    func sendBookmarkModelData() {
        if validateDelegate() {
            let data =
                EllieBookmarkModel(bookmarkViewTitle: bookmarkPreviewView.bookmarkedWebsiteTitle.text!,
                                   bookmarkURL: bookmarkUrlTextfield.text!, bookmarkedScreenShot: bookmarkPreviewView.bookmarkScreenShot.image!)
            delegate?.sendBookmarkModelData(bookmarkModel: data)
        }
        
        close()
    }

    override func close() {
        
        if bookmarkTextfield.isEditing {
            closeTextField(textField: bookmarkTextfield)
        } else if bookmarkUrlTextfield.isEditing {
            closeTextField(textField: bookmarkUrlTextfield)
        }
        
        super.close()
        reset()
        stopObservation()
    }
    
    
}

extension EllieCreateBookmarkPopupView : UITextFieldDelegate {
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        guard ( bookmarkTextfield.isEditing || bookmarkUrlTextfield.isEditing ) && !isKeyboardPresent
            else { return }
        
        
        if !firstKeyboardShown {
            firstKeyboardHeight = keyboardSize.height
            firstKeyboardShown = true
        }
        
        window?.frame.origin.y -= (firstKeyboardHeight * 0.66)
        
        print((firstKeyboardHeight * 0.66))
        isClosed = true
        isKeyboardPresent = true
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        guard window?.frame.origin.y != 0 && isKeyboardPresent
            else { return }
        
        window?.frame.origin.y += (firstKeyboardHeight * 0.66)
        print((firstKeyboardHeight * 0.66))

        isClosed = false
        isKeyboardPresent = false
    
    }
    
    func closeTextField(textField: UITextField) {
        
        print(textField.tag)
        
        switch (textField.tag) {
        case 0:
            if !(textField.text?.isEmpty)! {
                bookmarkPreviewView.bookmarkedWebsiteTitle.text = textField.text?.uppercased()
                bookmarkPreviewView.bookmarkedWebsiteTitle.addCharactersSpacing(spacing: EllieConstants.labelSpacing0p69)
            }
            break
        case 1:
            currentBookmarkURL.append(textField.text!)
            break
        default:
            break
        }
        
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        closeTextField(textField: textField)
        return true
    }
}
