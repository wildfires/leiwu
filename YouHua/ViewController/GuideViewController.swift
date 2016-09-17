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

        let openButton = UIButton(frame: CGRect(x: (Screen_Width - 100) / 2, y: (Screen_Height - 50) / 2, width: 100, height: 50))
        openButton.setTitle("打开app", forState: .Normal)
        openButton.setTitleColor(Color_Black, forState: .Normal)
        openButton.addTarget(self, action: #selector(openMain), forControlEvents: .TouchUpInside)
        openButton.layer.borderWidth = 0.5
        openButton.layer.borderColor = Color_Black.CGColor
        self.view.addSubview(openButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginAct() {
    
        let loginVC = LoginAndRegController()
        loginVC.initView(LoginRegViewType.Login)
        presentViewController(loginVC, animated: true, completion: nil)
    }
    
    func openMain() {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
        UIApplication.sharedApplication().keyWindow?.rootViewController = MainTabBarController()
    }
    
    deinit {
        print("GuideViewController deinit")
    }
}