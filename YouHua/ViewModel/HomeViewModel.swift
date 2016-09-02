//
//  HomeViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias HomeViewModelFinished = (success: Bool) -> ()

class HomeViewModel: UIViewController, WFNetwork, WFProgress, WFCacheData {
    
    var currentPage: Int = 0
    var topArray: Array<HomeModel> = []
    var tableArray: Array<HomeModel> = []
    
    
    var cellTopNumberOfRows: Int {
        
        return topArray.count
    }
    
    var cellNumberOfRows: Int {
        
        return tableArray.count
    }
    
    //请求数据([VideoNewsModel]?) -> Void)
    func fetchHomeData(finished: HomeViewModelFinished) {
        
        WFShowHUD("数据加载", status: WFStatusHUD.Success)
        var parameters: [String: AnyObject]
        
        parameters = [
            "page": currentPage
        ]
        
        WFGet(home_url, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["code"] == 200 else {
                
                //self.WFHideHUD()
                //self.WFShowHUD("无数据", status: WFStatusHUD.Failure)
                print(success, error, parameters)
                print("数据")
                finished(success: false)
                return
            }
            
            let tempArray = result["data"].arrayObject as! [[String : AnyObject]]
            //下拉刷新
            if self.currentPage == 1 {
                self.tableArray.removeAll()
            }
            
            print(tempArray)
            for dict in tempArray {
                //字典转模型
                let tmpModel = HomeModel(dict: dict)
                //添加到一个数组
                self.tableArray.append(tmpModel)
            }
            print(self.currentPage)
            finished(success: true)
            self.WFHideHUD()
        }
    }
    
    //请求数据([VideoNewsModel]?) -> Void)
    func fetchOneData(id: Int, finished: HomeViewModelFinished) {
        
        var parameters: [String: AnyObject]
        
        parameters = [
            "act": "home",
            "page": id
        ]
        
        WFGet(banner_url, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["code"] == 200 else {
                
                print(success, error, parameters)
                finished(success: false)
                return
            }
            
            let tempArray = result["data"].arrayObject as! [[String : AnyObject]]
                
            self.topArray.append(HomeModel(dict: tempArray[id]))
            //保存用户信息 self.saveAccount(tempArray[id] as! NSDictionary)
            finished(success: true)
        }
    }
    
    func fetchUserData(id: Int, finished: HomeViewModelFinished) {
        
        var parameters: [String: AnyObject]
        
        parameters = [
            "act": "user"
        ]
        
        WFGet(banner_url, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["code"] == 200 else {
                
                print(success, error, parameters)
                finished(success: false)
                return
            }
            
            let tempArray = result["data"].arrayObject as! [[String : AnyObject]]
                
            self.topArray.append(HomeModel(dict: tempArray[id]))
            //保存用户信息 self.saveAccount(tempArray[id] as! NSDictionary)
            finished(success: true)
        }
    }
    
    
    func clemoji() {
//        print("点击了表情")
//        let mineVC = MineViewController()
//        mineVC.userid = 2
//        mineVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(mineVC, animated: true)
    }
}
