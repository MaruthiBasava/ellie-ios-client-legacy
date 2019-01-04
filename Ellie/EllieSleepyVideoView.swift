//
//  EllieTiredVideoView.swift
//  Wide
//
//  Created by Mar Basava on 4/8/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit

class EllieSleepyVideoView: EllieYoutubeVideoView {

    var motivationalVideoURLS = ["CIaRiqSej00",
                                 "xctvXwngaw0",
                                 "uXCVp7MIyNw",
                                 "CIaRiqSej00"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        controllerLabel.text = "SLEEPY?"
        moreVideoButton.setTitle("I'm Still Sleepy", for: .normal)
        
        youtubeVideoURLS = motivationalVideoURLS
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
