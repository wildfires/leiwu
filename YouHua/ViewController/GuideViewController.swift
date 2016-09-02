//
//  GuideViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/31.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let openButton = UIButton(frame: CGRect(x: (SCREEN_WIDTH - 100) / 2, y: (SCREEN_HEIGHT - 50) / 2, width: 100, height: 50))
        openButton.setTitle("打开app", forState: .Normal)
        openButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        openButton.addTarget(self, action: #selector(loginAct), forControlEvents: .TouchUpInside)
        openButton.layer.borderWidth = 0.5
        openButton.layer.borderColor = UIColor.blackColor().CGColor
        self.view.addSubview(openButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginAct() {
    
        let loginVC = LoginAndRegController()
        loginVC.loginViewAction()
        presentViewController(loginVC, animated: true, completion: nil)
    }
    
    func openMain() {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
        UIApplication.sharedApplication().keyWindow?.rootViewController = MainTabBarController()
    }
}
