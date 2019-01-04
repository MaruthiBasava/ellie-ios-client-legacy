//
//  BaseViewController.swift
//  Wide
//
//  Created by Mar Basava on 3/29/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class HomeViewController: UIViewController {
        
    let youtubePopoutView = EllieYoutubeVideoPopupView()
    let headerPopup = EllieCreateHeaderPopupView()
    let sectionPopup = EllieCreateSectionPopupView()
    
    let topbar = EllieTopbar()
    let slider = EllieSectionSliderView()
    let materialSelectionTable = EllieMaterialSelectionTableView()
    
    lazy var footbar : EllieFootbar = {
        let f = EllieFootbar()
        f.a.addTarget(self, action: #selector(openPopup3), for: .touchUpInside)
        f.a.buttonImage.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(openPopup3)
        ))
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.white

    
        youtubePopoutView.navigationController = navigationController
        materialSelectionTable.navigationController = navigationController
        
        sectionPopup.navigationController = navigationController
        
        initializeLayouts()
    }

    func initializeLayouts() {
    
        view.addSubview(topbar)
        view.addSubview(slider)
        view.addSubview(materialSelectionTable)
        view.addSubview(footbar)
        
        view.addSubview(sectionPopup)
        
        topbar.easy.layout(
            Center(0.0),
            Top(0),
            Width(view.frame.width),
            Height(topbar.height)
)
    
        slider.easy.layout(
            Top(0).to(topbar),
            Width(view.frame.width),
            Height(slider.height)
)
        
        slider.flowLayout.itemSize.width = view.frame.width
        
        materialSelectionTable.easy.layout(
            Top(0).to(slider),
            Width(view.frame.width),
            Bottom(0).to(footbar)
)
    
        footbar.easy.layout(
            Center(0.0),
            Bottom(0),
            Width(view.frame.width),
            Height(footbar.height)
)
        
        sectionPopup.easy.layout(
            Center(0.0),
            Width(sectionPopup.windowSize.width),
            Height(sectionPopup.windowSize.height)
)
        
        
        topbar.initializeLayouts()
        materialSelectionTable.initializeLayouts()
        footbar.initializeLayouts()
        
        sectionPopup.initializeLayouts()
        
    }
    
    func openPopup() {
        youtubePopoutView.popIn()
    }
    
    func openPopup2() {
        headerPopup.popIn()
    }
    
    func openPopup3() {
        sectionPopup.popIn()
        navigationController?.navigationBar.isHidden = true
    }

    deinit {
        print("Released HomeViewController")
    }
    
}



