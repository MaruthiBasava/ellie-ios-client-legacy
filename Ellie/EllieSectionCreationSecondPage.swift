////
////  EllieSectionCreationSecondPage.swift
////  Ellie
////
////  Created by Mar Basava on 4/11/17.
////  Copyright © 2017 MarBasava. All rights reserved.
////
//
//import UIKit
//import EasyPeasy
//
//class EllieSectionCreationSecondPage: UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        sectionCollectionView.headerPreview = headerPreview
//
//        isHidden = true
//        
//        initializeLayouts()
//    }
//    
//    func initializeLayouts() {
//        
//        addSubview(headerPreview)
//        addSubview(backPageButton)
//        addSubview(sectionHeaderTitle)
//        addSubview(sectionCollectionView)
//        addSubview(createSectionButton)
//        addSubview(confirmationLabel)
//        
//        headerPreview.easy.layout(
//            Center(0.0),
//            Top(50),
//            Width(headerPreview.viewSize.width * 1.4),
//            Height(headerPreview.viewSize.height * 1.4)
//)
//        
//        headerPreview.layer.cornerRadius = (headerPreview.viewSize.height * 1.4) / 2
//        
//        sectionHeaderTitle.easy.layout(
//            Center(0.0),
//            Top(15).to(headerPreview),
//            Left(15)
//)
//        
//        
//        sectionCollectionView.easy.layout(
//            Center(0.0),
//            Top(10).to(sectionHeaderTitle),
//            Width(windowSize.width),
//            Height(70)
//)
//        
//        backPageButton.easy.layout(
//            Center(0.0),
//            Top(30).to(sectionCollectionView),
//            Bottom(30).to(confirmationLabel),
//            Width(120),
//            Height(45)
//)
//        
//        confirmationLabel.easy.layout(
//            Center(0.0),
//            Bottom(10).to(createSectionButton)
//)
//        
//        createSectionButton.easy.layout(
//            Center(0.0),
//            Bottom(20),
//            Width(190),
//            Height(45)
//)
//        
//    }
//    
//    func backSelection() {
//       fadeOut()
//       firstPage.fadeIn()
//    }
//
//    func createSection() {
//        popupView.closeView()
//        Timer.scheduledTimer(timeInterval: 0.6,
//                             target: self,
//                             selector: #selector(go),
//                             userInfo: nil,
//                             repeats: false);
//    }
//    
//    func go() {
//        navigationController.navigationBar.isHidden = false
//    }
//    
//    func reset() {
//        Timer.scheduledTimer(timeInterval: 0.35,
//                             target: self,
//                             selector: #selector(backSelection),
//                             userInfo: nil,
//                             repeats: false);
//
//    }
//    
//    var windowSize = CGSize(width: 300, height: 500)
//    
//    var headerPreview = EllieHeaderSelectionPreviewView()
//    var sectionCollectionView = EllieSectionHeaderSelectionView()
//    var popupView : EllieCreateSectionPopupView!
//
//    var navigationController : UINavigationController!
//    
//    var firstPage : UIView!
//    var popviewTitle : UILabel!
//    
//    lazy var backPageButton : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
//        
//        button.backgroundColor = UIColor.EllieColors.flatLightBlack
//        button.titleLabel?.textColor = UIColor.white
//        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
//        
//        button.layer.shadowColor = UIColor.EllieColors.flatLightBlack.cgColor
//        button.layer.cornerRadius = 3
//        button.setTitle("Back", for: .normal)
//        
//        
//        button.addTarget(self, action: #selector(backSelection), for: .touchUpInside)
//        
//        
//        return button
//    }()
//    
//    lazy var createSectionButton : EllieCornerRoundedUIButton = {
//        let button = EllieCornerRoundedUIButton()
//        
//        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
//        button.titleLabel?.textColor = UIColor.white
//        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
//        
//        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor
//        button.layer.cornerRadius = 3
//        
//        button.setTitle("Create Section", for: .normal)
//        
//        button.addTarget(self, action: #selector(createSection), for: .touchUpInside)
//        
//        
//        return button
//    }()
//    
//    lazy var sectionHeaderTitle : UILabel = {
//        let label = UILabel()
//        let b = "header"
//        let a = "Pick a \(b)."
//        label.applyEllieLabelProperties(a: a, b: b, starting: 0)
//        label.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 17)
//        label.textAlignment = .center
//        label.textColor = UIColor.EllieColors.flatDarkGreen
//        
//        return label
//    }()
//    
//    lazy var confirmationLabel : UILabel = {
//        let label = UILabel()
//        label.text = "When you're ready, click this button."
//        label.font = UIFont(name: WideFonts.josefinSansRegular, size: 15)
//        label.textAlignment = .center
//        label.textColor = UIColor.EllieColors.flatMedimumBlack
//        
//        return label
//    }()
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
