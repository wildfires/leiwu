//
//  SettingViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/2.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initView() {
        
        self.title = "设置"
        
        self.view.backgroundColor = UIColor.whiteColor()
    }

//  MARK: - Delegate
    
    deinit {
        print("SettingViewController deinit")
    }
}
