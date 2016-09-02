//
//  MainTabBarController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var userID: Bool {
        
        return NSUserDefaults.standardUserDefaults().boolForKey("isLogin")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTabBarView()
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        // 如果点击了中间的controller的tag viewController.tabBarItem.tag == 3
        
        guard viewController.tabBarItem.tag == 3 else {
            return true
        }
        //判断用户是否登陆过
        guard userID == false else {
            return true
        }
        
        // 弹出一个controller
        let loginVC = LoginAndRegController()
        loginVC.loginViewAction()
        
        //登陆后改变tabbar当前view
        loginVC.dismissLoginViewController = { [weak self] in
            self!.selectedIndex = 0
        }
        
        presentViewController(loginVC, animated: true, completion: nil)
        // 不允许选择这个页面页面
        return false
    }
}

extension MainTabBarController {
    
    //初始化TabBar
    func initTabBarView() {
        
        addChildViewController(HomeViewController(), title: "首页", image: "home_normal", selected: "home_active")
        addChildViewController(FindViewController(), title: "发现", image: "find_normal", selected: "find_active")
        //addCenterButton(ComposeViewController(), image: "post_normal")
        addChildViewController(MallViewController(), title: "好物", image: "message_normal", selected: "message_active")
        addChildViewController(MineViewController(), title: "我的", image: "mine_normal", selected: "mine_active")
    }
    
    //添加TabBar Item
    func addChildViewController(childVC: UIViewController, title: String, image: String, selected: String) {
        //设置TabBar字体颜色
        tabBar.tintColor = UIColor.redColor()
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: image)?.imageWithRenderingMode(.AlwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selected)?.imageWithRenderingMode(.AlwaysOriginal)
        //设置点击后字体颜色
        childVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orangeColor()], forState: .Selected)
        
        if title == "我的" {
            childVC.tabBarItem.tag = 3
        }
        
        //设置导航控制器
        let nav = UINavigationController(rootViewController: childVC)
        addChildViewController(nav)
    }
}