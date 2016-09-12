//
//  WFCacheData.swift
//  YouHua
//
//  Created by 高洋 on 16/8/24.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

protocol WFCacheData {
    
    
}

extension WFCacheData {
    
    //保存缓存数据
    func setCacheData() {
        
        
    }
    //获取缓存数据
    func getCacheData(parameters: [String : AnyObject]?) -> NSArray {
        
//        var parameters: [String: AnyObject]
//        
//        parameters = [
//            "act": "home",
//            "page": id
//        ]
        
        return []
    }
    
    
    
    //缓存发现页banner数据
    func cacheFindBannerData() {
        
    }
    
    //缓存发现页list数据
    func cacheFindListData() {
        
    }
    
    //缓存好物banner数据
    func cacheMallBannerData() {
        
    }
    
    //缓存好物list数据
    func cacheMallListData() {
        
    }
    
    func saveAccount(account: NSDictionary) {
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        //保存用户信息
        userDefaults.setObject(account, forKey: "account")
        userDefaults.setObject(account["uid"], forKey: "userID")
        userDefaults.setObject(account["user"], forKey: "userName")
        userDefaults.setObject(account["pass"], forKey: "userPass")
    }
    
    func dissAccount() {
        
        saveAccount([:])
    }
    
    func isCheckingLogined() -> Bool {
        
        return false
    }
    
    func getAccount() -> NSDictionary {
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let userAccount: NSDictionary = userDefaults.objectForKey("account") as! NSDictionary
        
        return userAccount
    }
    
    func getUserID() -> String {
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let userID: String = userDefaults.objectForKey("userID") as! String
        
        return userID
    }
    
    func getUserName() -> String {
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let userName: String = userDefaults.objectForKey("userName") as! String
        
        return userName
    }
    
    func getUserPass() -> String {
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let userPass: String = userDefaults.objectForKey("userPass") as! String
        
        return userPass
    }
    
}