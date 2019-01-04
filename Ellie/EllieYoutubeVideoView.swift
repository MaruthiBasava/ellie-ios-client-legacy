//
//  EllieMotivationVideoView.swift
//  Wide
//
//  Created by Mar Basava on 4/8/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy
import SimpleAnimation

class EllieYoutubeVideoView: UIView, UIWebViewDelegate {
    
    lazy var controllerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.montserratBold, size: 25)
        label.textAlignment = .center
        label.textColor = UIColor.EllieColors.flatDarkGreen
        
        return label
    }()
    
    lazy var youtubeVideoView : UIWebView = {
        let webView = UIWebView()
        webView.allowsInlineMediaPlayback = true
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        
        return webView
    }()
    
    lazy var moreVideoButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.montserratRegular, size: 15)
        
        button.layer.cornerRadius = 6.81
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        
        button.addTarget(self, action: #selector(generateNewVideo), for: .touchUpInside)
        
        return button
    }()
    
    var youtubeVideoURLS = [""]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        youtubeVideoView.delegate = self
        
        addSubview(controllerLabel)
        addSubview(youtubeVideoView)
        addSubview(moreVideoButton)
                
        Timer.scheduledTimer(timeInterval: 0.05,
                             target: self,
                             selector: #selector(generateNewVideo),
                             userInfo: nil,
                             repeats: false);

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        
    }
    
    func initializeLayouts() {
        
        controllerLabel.easy.layout(
            Center(0.0),
            Top(80)
)
        
        youtubeVideoView.easy.layout(
            Center(0.0),
            Top(10).to(controllerLabel),
            Left(-2),
            Right(5)
)
        
        moreVideoButton.easy.layout(
            Center(0.0),
            Top(20).to(youtubeVideoView),
            Bottom(20),
            Width(250),
            Height(50)
)
        
    }
    
    func generateNewVideo() {
        
        let randomIndex = Int(arc4random_uniform(UInt32(youtubeVideoURLS.count)))
        let myHTML = "<iframe width=\"\(youtubeVideoView.frame.width)\" height=\"\(youtubeVideoView.frame.width)\" src=\"https://www.youtube.com/embed/\(youtubeVideoURLS[randomIndex])?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"
        youtubeVideoView.loadHTMLString(myHTML, baseURL: nil)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
