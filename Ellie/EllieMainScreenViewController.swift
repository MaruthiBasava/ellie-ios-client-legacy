//
//  EllieMainScreenViewController.swift
//  Ellie
//
//  Created by Mar Basava on 12/2/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieMainScreenViewController: UIViewController {

    lazy var sceneryView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.EllieColors.flatDarkerMediumBlack
        return view
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.\

        initializeLayouts()
        
    }

    func initializeLayouts() {
        view.addSubview(sceneryView)
        
        sceneryView.easy.layout(Top(0),
                                Left(0),
                                Right(0),
                                Height(200))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

