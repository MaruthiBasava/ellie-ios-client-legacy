//
//  EllieExpandedSectionViewController.swift
//  Ellie
//
//  Created by Mar Basava on 4/14/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieExpandedSectionViewController: UIViewController {

    let topbar = EllieTopbar()
    let footbar = EllieFootbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        view.backgroundColor = UIColor.white
        
        initializeLayouts()
    }
    
    func initializeLayouts() {
        view.addSubview(topbar)
        view.addSubview(footbar)
        
        topbar.easy.layout(
            Center(0.0),
            Top(0),
            Width(view.frame.width),
            Height(topbar.height)
)
        
        footbar.easy.layout(
            Center(0.0),
            Bottom(0),
            Width(view.frame.width),
            Height(footbar.height)
)
        
        topbar.initializeLayouts()
        footbar.initializeLayouts()
        
    }
    
    deinit {
        print("released")
    }

}
