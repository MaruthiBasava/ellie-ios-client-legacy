//
//  EllieDestressedVideoView.swift
//  Wide
//
//  Created by Mar Basava on 4/8/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit

class EllieDestressedVideoView: EllieYoutubeVideoView {

    var motivationalVideoURLS = ["9nZMHBDw8os",
                                 "5dsGWM5XGdg",
                                 "iRXJXaLV0n4",
                                 "qQxoMy85ZO0"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        controllerLabel.text = "STRESSED?"
        moreVideoButton.setTitle("I'm Still Stressed", for: .normal)
        
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
