//
//  ShowViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/7.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    var show_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "\(show_id)"
    }
    
    deinit {
        print("ShowViewController deinit")
    }
}
