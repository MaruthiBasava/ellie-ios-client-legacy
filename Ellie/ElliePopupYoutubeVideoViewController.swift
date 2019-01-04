//
//  ElliePopupYoutubeVideoViewController.swift
//  Wide
//
//  Created by Mar Basava on 4/9/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class ElliePopupYoutubeVideoViewController: UIViewController {

    var videoView : EllieYoutubeVideoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        navigationController?.navigationBar.isHidden = false

        view.addSubview(videoView)
        
        initializeLayouts()
    }
    
    func initializeLayouts() {
        videoView.easy.layout(
            Center(0.0),
            Width(view.frame.width),
            Height(view.frame.height)
)
    
        videoView.initializeLayouts()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    deinit {
        print("Released ElliePopupYoutubeVideoViewController")
    }
    
}
