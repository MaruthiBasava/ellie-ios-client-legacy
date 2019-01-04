//
//  ExampleViewController.swift
//  Ellie
//
//  Created by Mar Basava on 4/13/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class ExampleViewController: UIViewController {

    let topbar = EllieTopbar()
    let footbar = EllieFootbar()
  
    lazy var b : EllieCornerRoundedUIButton = {
        let button = EllieCornerRoundedUIButton()
        
        button.backgroundColor = UIColor.EllieColors.flatDarkGreen
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: WideFonts.glacialIndifferenceRegular, size: 17)
        
        button.layer.shadowColor = UIColor.EllieColors.flatDarkGreen.cgColor
        button.layer.cornerRadius = 3
        button.setTitle("Create Header", for: .normal)
        
        button.addTarget(self, action: #selector(openPopup2), for: .touchUpInside)
        
        
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        view.addSubview(b)
        
        b.easy.layout(Center(0),
                      Width(100),
                      Height(100))
        
        
        view.addSubview(topbar)
        view.addSubview(footbar)
        
        topbar.easy.layout(
            Center(0.0),
            Top(0),
            Width(view.frame.width),
            Height(topbar.height))
        
        footbar.easy.layout(
            Center(0.0),
            Bottom(0),
            Width(view.frame.width),
            Height(footbar.height))
        
        topbar.initializeLayouts()
        footbar.initializeLayouts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openPopup2() {
        DispatchQueue.main.async {
            [weak self] in
            self?.navigationController?.pushViewController(HomeViewController(), animated: true)
        }
    }
    

    deinit {
        print("release")
    }

}
