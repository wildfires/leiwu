//
//  HomeViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias HomeViewModelFinished = (success: Bool) -> ()

class HomeViewModel: NSObject, WFProgress, WFCacheData {
    
    var currentPage: Int = 0
    var topArray: Array<HomeModel> = []
    //var tableArray: Array<HomeModel> = []
    var tableArray = [HomeModel]()
    
    var cellTopNumberOfRows: Int {
        
        return topArray.count
    }
    
    var cellNumberOfRows: Int {
        
        return tableArray.count
    }
    
    //请求数据([VideoNewsModel]?) -> Void)
    func fetchHomeData(finished: (success: [HomeModel]) -> ()) {
        
        //WFShowHUD("数据加载", status: WFStatusHUD.Success)
        var parameters: [String: AnyObject]
        
        parameters = [
            "page": currentPage
        ]
        
        WFNetwork.shareNetwork.WFGet(home_url, parameters: parameters) { (success, result, error) in
            
            if let result = result {
                
                let code = result["code"].intValue
                let info = result["info"].stringValue
                
                guard code == RETURN_CODE else {
                    
                    self.WFShowHUD(info, status: WFStatusHUD.Failure)
                    return
                }
                
                if let data = result["data"].arrayObject {
                    
                    
                    //下拉刷新
                    if self.currentPage == 1 {
                        self.tableArray.removeAll()
                    }
                    
                    var tempArray = [HomeModel]()
                    for dict in data {
                        //字典转模型
                        let tempModel = HomeModel(dict: dict as! [String : AnyObject])
                        //添加到一个数组
                        tempArray.append(tempModel)
                    }
                    finished(success: tempArray)
                    //self.WFHideHUD()
                }
            }
        }
    }
    
    //请求数据([VideoNewsModel]?) -> Void)
    func fetchOneData(id: Int, finished: HomeViewModelFinished) {
        
        var parameters: [String: AnyObject]
        
        parameters = [
            "act": "home",
            "page": id
        ]
        
        WFNetwork.shareNetwork.WFGet(banner_url, parameters: parameters) { (success, result, error) in
            
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
        
        WFNetwork.shareNetwork.WFGet(banner_url, parameters: parameters) { (success, result, error) in
            
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
