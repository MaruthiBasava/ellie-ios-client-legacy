//
//  EllieScrollableModalView.swift
//  Ellie
//
//  Created by Mar Basava on 7/7/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import EasyPeasy
import UIKit


protocol EllieScrollableModalViewDelegate : class {
    func updateModalTopConstraints(topConstraint : CGFloat)
}

class EllieScrollableModalView : EllieCloseablePopupView {
    
    let slideConstant : CGFloat = 0.05
    
    var gestureReconginzer : UIPanGestureRecognizer?
    var topDistance : CGFloat = 80
    
    var screenMaxY = UIScreen.main.bounds.maxY
    
    var animator : UIViewPropertyAnimator?
    
    var lastTouchPosition: CGFloat?
    
    var isStopped = true
    
    var reachedBottom = false
    
    var isKeyboardOn = false
    
    weak var delegate : EllieScrollableModalViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        height = 1900
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
        
        gestureReconginzer = UIPanGestureRecognizer(target: self, action: #selector(catchGestrue(gesture:)))
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(stopPanning(gesture:)))
        singleTapGesture.numberOfTapsRequired = 1
        
        addGestureRecognizer(singleTapGesture)
        addGestureRecognizer(gestureReconginzer!)
        
        animator = UIViewPropertyAnimator()
        
    }
    
    func stopPanning(gesture:UIPanGestureRecognizer) {
        
        if (animator?.isRunning)! {
            animator?.stopAnimation(true)
            isStopped = true
            updateProgress()
        }
    
    }
    

    
    func catchGestrue(gesture:UIPanGestureRecognizer){

        switch(gesture.state){
        case .changed:
            
            let translation = gesture.translation(in: self)
            
            let a = (translation.y + frame.origin.y)
           
            if a <= topDistance && screenMaxY <= frame.maxY && !reachedBottom {
                frame.origin.y += translation.y
            }
                
            gesture.setTranslation(CGPoint.zero, in: self)
            
            updateProgress()
    
            break
        case .ended:
            let velocity = gesture.velocity(in: self)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 350
            let slideFactor = slideConstant * slideMultiplier
            let finalY = frame.origin.y + (velocity.y * slideFactor) / 2
            
            
            if (animator?.isRunning)! {
                animator?.stopAnimation(true)
            }
            
            if velocity.y > 0 {
                dragDown(slideFactor: slideFactor, finalY: finalY)
            }
            else {
                dragUp(slideFactor: slideFactor, finalY: finalY)
            }
            
            updateProgress()
            
            break
        default: break
        
        }
    }
    
    func updateProgress() {
        let b = returnLinearRelationship(x1: topDistance,
                                         y1: 0,
                                         x2: (topDistance-height) - UIScreen.main.bounds.height,
                                         y2: 100,
                                         fx: frame.origin.y)/(29*(height/1000))
        print(b)
        progress.setProgress(Float(b), animated: true)
    }
    
    func returnLinearRelationship(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, fx: CGFloat) -> CGFloat {
        return (y2-y1)/(x2-x1)*(fx-x1)+y1
    }
    
    func dragDown(slideFactor : CGFloat, finalY: CGFloat) {
    
        animator =
        UIViewPropertyAnimator
            .runningPropertyAnimator(withDuration:Double(slideFactor*2),
                       delay: 0,
                       options: [.curveEaseOut ,.allowUserInteraction],
                       animations: {
                        
                        self.frame.origin.y = finalY
                        
                        if self.topDistance < self.frame.minY {
                            self.frame.origin.y = self.topDistance
                        }
                        
                        self.reachedBottom = false
                       
                        },
                       completion:  { [weak self] finished in
                            self?.isStopped = true
                        })
        animator?.startAnimation()

    }
    
    func dragUp(slideFactor : CGFloat, finalY: CGFloat) {
        
        animator =
        UIViewPropertyAnimator
            .runningPropertyAnimator(withDuration:Double(slideFactor*2),
                       delay: 0,
                       options: [.curveEaseOut ,.allowUserInteraction],
                       animations: {
                       
                        if (self.height+self.topDistance >= UIScreen.main.bounds.height) {
                        
                            self.frame.origin.y = finalY
                        
                            if self.screenMaxY > self.frame.maxY {
                                self.frame.origin.y += (self.screenMaxY - self.frame.maxY)
                                self.reachedBottom = true
                            }
                        }
                        
                       },
                       completion:  { [weak self] finished in
                        self?.isStopped = true

                        })
        animator?.startAnimation()
        
    }
    
    func updateTopConstraint() {
        guard (delegate != nil)
        else { return }
        
        delegate?.updateModalTopConstraints(topConstraint: frame.origin.y)
        
    }
    
    override func initializeLayouts() {
            super.initializeLayouts()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func keyboardWillShow(notification: NSNotification) {
       
        if isKeyboardOn == false {
            lastTouchPosition = frame.origin.y
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                window?.frame.origin.y -= keyboardSize.height
            }
            
            isKeyboardOn = true;
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        updateTopConstraint()
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            window?.frame.origin.y += keyboardSize.height
        }
        
        isKeyboardOn = false;
        
    }
    
    lazy var progress: UIProgressView = {
        let a = UIProgressView()
        a.progressTintColor = UIColor.EllieColors.flatDarkGreen
        a.trackTintColor = UIColor.EllieColors.flatShadowGray
        a.setProgress(0, animated: false)
        return a
    }()
    
}


