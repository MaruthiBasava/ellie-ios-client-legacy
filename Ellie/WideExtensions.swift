//
//  WideExtensions.swift
//  Wide
//
//  Created by Mar Basava on 3/29/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    struct EllieColors {
        static var flatDarkGreen = UIColor(red: 8/255, green: 196/255,blue: 148/255, alpha: 1)
        static var flatLightBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        static var flatMedimumBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50)
        static var flatGray = UIColor(red: 246/255, green: 238/255, blue: 238/255, alpha: 1)
        static var flatShadowGray = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        static var flatDarkerMediumBlack = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        static var flatAuqaBlue = UIColor(red: 37/255, green: 206/255, blue: 209/255, alpha: 1)
        static var flatNiceBlue = UIColor(red: 77/255, green: 87/255, blue: 223/255, alpha: 1)
        
        static var videoMaterialRed = UIColor(red: 234/255, green: 82/255, blue: 111/255, alpha: 1)
        static var pictureMaterialGreen = UIColor(red: 8/255, green: 196/255, blue: 148/255, alpha: 1)
        static var fileMaterialBlue = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
        static var websiteMaterialBlue = UIColor(red: 77/255, green: 87/255, blue: 223/255, alpha: 1)
        static var audioMaterialYellow = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
        static var noteMaterialPurple = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1)

    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UILabel {
    
    var computedText : String {
        
        set {
            text = newValue
            addCharactersSpacing(spacing: EllieConstants.labelSpacing2p24)
        }
        
        get {
            guard let p_text = text
                else { return "" }
            return p_text
        }
        
    }
    
    func addCharactersSpacing(spacing:CGFloat) {
        let attributedString = NSMutableAttributedString(string: text!)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, (text?.characters.count)!))
        attributedText = attributedString
    }
    
    func applyEllieLabelProperties(a: String, b: String, starting : Int) {
        let attributedString = NSMutableAttributedString.init(string: a)
        attributedString.setAttributes([NSForegroundColorAttributeName: UIColor.EllieColors.flatDarkGreen],
                                       range: NSMakeRange(starting, b.characters.count))
        attributedText = attributedString
    }
    
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        let rect = self.bounds
        mask.frame = rect
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func snapshot(of rect: CGRect? = nil) -> UIImage? {
        // snapshot entire view
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let wholeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // if no `rect` provided, return image of whole view
        
        guard let image = wholeImage,
            let rect = rect
            else { return wholeImage }
        
        // otherwise, grab specified `rect` of image
        
        let scale = image.scale
        let scaledRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
