//
//  WideNavigationViewController.swift
//  Wide
//
//  Created by Mar Basava on 3/29/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit

class EllieNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        navigationBar.tintColor = UIColor.white
//        navigationBar.barTintColor = UIColor.WideTheme.flatPurple
//        navigationBar.isTranslucent = false
//
//        
//        navigationBar.titleTextAttributes = [
//            NSFontAttributeName : UIFont(name: WideFonts.ralewayMedium, size: 18)!,
//            NSForegroundColorAttributeName : UIColor.white
//)
//        
        navigationBar.tintColor = UIColor.EllieColors.flatDarkGreen
        navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: "Glacial Indifference", size: 20)!,
            NSForegroundColorAttributeName : UIColor.EllieColors.flatDarkGreen]
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
                
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
