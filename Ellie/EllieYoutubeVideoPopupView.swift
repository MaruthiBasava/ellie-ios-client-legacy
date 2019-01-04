//
//  EllieYoutubeVideoPopupView.swift
//  Wide
//
//  Created by Mar Basava on 4/9/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieYoutubeVideoPopupView: EllieCloseablePopupView {

    var navigationController : UINavigationController!
    
    var windowSize = CGSize(width: 300, height: 350)
    
    lazy var motivationButton : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
        
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
    
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor
       
        
        button.addTarget(self, action: #selector(moveToMotivation), for: .touchUpInside)

        
        return button
    }()
    
    lazy var stressedButton : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
        
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
        
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor

        
        button.addTarget(self, action: #selector(moveToStressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var sleepyButton : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
        
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
        
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor

        button.addTarget(self, action: #selector(moveToSleepy), for: .touchUpInside)
        return button
    }()
    
    lazy var studyTipsButton : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
        
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 14)
        
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor

        
        button.addTarget(self, action: #selector(moveToTips), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        popviewTitle.addCharactersSpacing(spacing: 4.20, text: "NEED HELP?")
        motivationButton.setTitle("I Need Motivation", for: .normal)
        stressedButton.setTitle("I'm Stressed", for: .normal)
        sleepyButton.setTitle("I'm Sleepy", for: .normal)
        studyTipsButton.setTitle("I Need Tips To Be Successful", for: .normal)

    }
    
    override func initializeLayouts() {
        
        addSubview(motivationButton)
        addSubview(stressedButton)
        addSubview(sleepyButton)
        addSubview(studyTipsButton)
        
        super.initializeLayouts()
       
        motivationButton.easy.layout(
            Center(0.0),
            Top(35).to(popviewTitle),
            Width(235),
            Height(50)
)
        
        stressedButton.easy.layout(
            Center(0.0),
            Top(10).to(motivationButton),
            Width(235),
            Height(50)
)
        
        sleepyButton.easy.layout(
            Center(0.0),
            Top(10).to(stressedButton),
            Width(235),
            Height(50)
)
        
        studyTipsButton.easy.layout(
            Center(0.0),
            Top(10).to(sleepyButton),
            Width(235),
            Height(50)
)
 
    }
    
    func moveToMotivation() {
        let viewController = ElliePopupYoutubeVideoViewController()
        viewController.videoView = EllieMotivationVideoView()
        navigationController.pushViewController(viewController , animated: true)
    }
    
    func moveToSleepy() {
        let viewController = ElliePopupYoutubeVideoViewController()
        viewController.videoView = EllieSleepyVideoView()
        navigationController.pushViewController(viewController , animated: true)
    }
    
    func moveToStressed() {
        let viewController = ElliePopupYoutubeVideoViewController()
        viewController.videoView = EllieDestressedVideoView()
        navigationController.pushViewController(viewController , animated: true)
    }
    
    func moveToTips() {
        let viewController = ElliePopupYoutubeVideoViewController()
        viewController.videoView = EllieStudyTipsVideoView()
        navigationController.pushViewController(viewController , animated: true)
    }
    
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
