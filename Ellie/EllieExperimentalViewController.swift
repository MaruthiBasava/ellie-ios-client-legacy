//
//  EllieExperimentalViewController.swift
//  Ellie
//
//  Created by Mar Basava on 7/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieExperimentalViewController: UIViewController {

    var test = EllieCreateSectionModalView()
    fileprivate var waterView: EllieWaveView?
    
    
    lazy var viewA : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        test.delegate = self
        
        initializeLayouts()
        
//        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 200)
//        waterView = EllieWaveView(frame: frame, color: UIColor.white)
//        waterView!.backgroundColor = UIColor.EllieColors.flatDarkGreen
//        
//        // Add WaveView
//        self.view.addSubview(waterView!)
//        
//        // Start wave
//        waterView!.start()
        
        initializeLayouts()
    }
    
    func initializeLayouts() {
    
        view.addSubview(viewA)
        
        viewA.easy.layout(
            Center(0.0),
            Size(100)
)
        
        
        postLayoutInitialization()
        
    }
    
    func postLayoutInitialization() {
    
    
        
    }
    
    
    func addCircleTo(view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.frame
        
        let path = CGMutablePath()
        
    }
    
    
    
    override var prefersStatusBarHidden: Bool { return true }
    
}
extension EllieExperimentalViewController : EllieScrollableModalViewDelegate {
    
    func updateModalTopConstraints(topConstraint : CGFloat) {
        test.easy.layout(Top(test.lastTouchPosition!))
    }
    
}
