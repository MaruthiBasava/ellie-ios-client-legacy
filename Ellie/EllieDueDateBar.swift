//
//  EllieDueDateBar.swift
//  Ellie
//
//  Created by Mar Basava on 4/14/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieDueDateBar: EllieRoundedView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 0
        layer.shadowOffset = CGSize.init(width: 0, height: 2)
        layer.zPosition = 2
    }
    
    func initializeLayouts() {
        addSubview(dueDateLabel)
        
        dueDateLabel.easy.layout(
            Center(0.0)
)
    }
    
    var height = CGFloat(35)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dueDateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.josefinSansRegular, size: 16)
        label.textColor = UIColor.EllieColors.flatDarkGreen
        label.textAlignment = .center
//        label.addCharactersSpacing(spacing: 1, text: "Due April 11th")
        return label
    }()

}
