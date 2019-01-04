//
//  EllieBrowserBottomBar.swift
//  Ellie
//
//  Created by Mar Basava on 9/3/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy
import UIKit

protocol EllieBrowserBottomBarDelegate : class {
    func downloadCurrentLink()
    func goBack()
    func goForward()
    func pull(to: CGFloat)
    func bookmark()
    func toggleFullscreen()
}


class EllieBrowserBottomBar: EllieRoundedView {
    
    var height : CGFloat = 210
    var initialTop : CGFloat = -50
    var finalTop : CGFloat?
    
    var isOpen = false
    
    weak var delegate : EllieBrowserBottomBarDelegate?
    
    lazy var taskBar : EllieBrowserBottomTaskBar = {
        let a = EllieBrowserBottomTaskBar()
        
        a.goForwardButton.appendTarget(target: self, selector: #selector(goForward))
        a.bookmarkButton.appendTarget(target: self, selector: #selector(bookmark))
        a.downloadCurrentLinkButton.appendTarget(target: self, selector: #selector(downloadCurrentLink))
        a.goBackButton.appendTarget(target: self, selector: #selector(goBack))
        a.pullButton.appendTarget(target: self, selector: #selector(pull))
        
        a.backgroundColor = UIColor.clear
        return a
        
    }()
    
    lazy var websiteCollection : EllieBrowserWebsiteDownloadView = {
        let a = EllieBrowserWebsiteDownloadView()
        a.layer.shadowRadius = 0
        return a
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        finalTop = (height) * -1 + 10
        
        layer.cornerRadius = 0
        layer.shadowRadius = 2
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(pullGesture))
        swipeDown.direction = .down
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(pullGesture))
        swipeUp.direction = .up
        
        addGestureRecognizer(swipeDown)
        addGestureRecognizer(swipeUp)
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(taskBar)
        addSubview(websiteCollection)
        
        taskBar.easy.layout(
            Center(0.0),
            Top(0),
            Right(0),
            Left(0),
            Height(taskBar.height))
    
        websiteCollection.easy.layout(
            Center(0.0),
            Top(5).to(taskBar),
            Right(0),
            Left(0),
            Height(websiteCollection.height))
        
    }
    
    func validateDelegate() -> Bool {
        return delegate != nil
    }
    
    func downloadCurrentLink() {
        if validateDelegate() {
            delegate?.downloadCurrentLink()
        }
        
    }
    
    func goBack() {
        if validateDelegate() {
            delegate?.goBack()
        }
    }
    
    func goForward() {
        if validateDelegate() {
            delegate?.goForward()
        }
    }
    
    func rotatePullImage() {
        //        DispatchQueue.main.async { [unowned self] in
        //            UIView.animate(withDuration: 0.5, animations: { () -> Void in
        //                self.taskBar.pullButton.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(180 * .pi))
        //                self.layoutIfNeeded()
        //
        //            }) { (succeed) -> Void in
        //
        //            }
        //        }
    }
    
    func pullGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.up:
            if validateDelegate() && !isOpen{
                delegate?.pull(to: finalTop!)
                rotatePullImage()
                isOpen = true
            }
            break
        case UISwipeGestureRecognizerDirection.down:
            if validateDelegate() && isOpen{
                delegate?.pull(to: initialTop)
                rotatePullImage()
                isOpen = false
            }
            break
        default:
            break
        }
    }
    
    func pull() {
        if validateDelegate() && !isOpen{
            delegate?.pull(to: finalTop!)
            rotatePullImage()
            isOpen = true
        }
        else {
            delegate?.pull(to: initialTop)
            rotatePullImage()
            isOpen = false
        }
    }
    
    func bookmark() {
        if validateDelegate() {
            delegate?.bookmark()
        }
    }
    
    func toggleFullscreen() {
        if validateDelegate() {
            delegate?.toggleFullscreen()
        }
    }
    
}
