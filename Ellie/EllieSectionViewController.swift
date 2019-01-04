//
//  EllieSectionViewController.swift
//  Ellie
//
//  Created by Mar Basava on 4/14/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieSectionViewController: UIViewController {

    let topbar = EllieTopbar()
    let dueDateBar = EllieDueDateBar()
    let sectionSelectionTable = EllieSectionSelectionTableView()
    let footbar = EllieFootbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.white
        
        sectionSelectionTable.navigationController = navigationController

        view.addSubview(topbar)
        view.addSubview(dueDateBar)
        view.addSubview(sectionSelectionTable)
        view.addSubview(footbar)
        
        initializeLayouts()
    }
    
    func initializeLayouts() {
    
        
        topbar.easy.layout(
            Center(0.0),
            Top(0),
            Width(view.frame.width),
            Height(topbar.height)
)
        
        dueDateBar.easy.layout(
            Top(0).to(topbar),
            Width(view.frame.width),
            Height(dueDateBar.height)
)
        
        sectionSelectionTable.easy.layout(
            Top(0).to(dueDateBar),
            Width(view.frame.width),
            Bottom(0).to(footbar)
)
        
        footbar.easy.layout(
            Center(0.0),
            Bottom(0),
            Width(view.frame.width),
            Height(footbar.height)
)
        
        topbar.initializeLayouts()
        dueDateBar.initializeLayouts()
        sectionSelectionTable.initializeLayouts()
        footbar.initializeLayouts()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
         print("released")
    }

}
