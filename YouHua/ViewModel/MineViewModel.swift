//
//  MineViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/9/5.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias MineViewModelFinished = (success: Bool) -> ()

class MineViewModel: NSObject, WFProgress {

    var model: UserModel?
    //获取用户对象
    static var accountModel: UserModel? {
        
        return MineViewModel.shareAccount()
    }
    
    //设计单例
    //static let sharedUserAccount: MineViewModel = MineViewModel()
    
//  MARK: -用户数据
    //归档帐号路径
    static let accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! + "/account.plist"
    
    //保存归档用户数据
    func saveAccount() {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLogin")
        //NSKeyedArchiver.archiveRootObject(self, toFile: MineViewModel.accountPath)
    }
    
    //获取用户对象（这可不是单例哦，只是对象静态化了，保证在内存中不释放）
    static func shareAccount() -> UserModel? {
        
//        guard accountModel != nil else {
//            return accountModel
//        }
        return NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserModel
    }
    
//    //归档
//    func encodeWithCoder(aCoder: NSCoder) {
//        
//        aCoder.encodeObject(model.uid, forKey: "uid_key")
//        aCoder.encodeObject(model.token, forKey: "token_key")
//        aCoder.encodeObject(model.avatar, forKey: "avatar_key")
//        aCoder.encodeObject(model.nick, forKey: "nick_key")
//    }
//    
//    //解档
//    required init?(coder aDecoder: NSCoder) {
//        
//        model.uid = aDecoder.decodeObjectForKey("uid_key") as! Int
//        model.token = aDecoder.decodeObjectForKey("token_key") as! String
//        model.avatar = aDecoder.decodeObjectForKey("avatar_key") as! String
//        model.nick = aDecoder.decodeObjectForKey("nick_key") as! String
//    }
    
    
//  MARK: -属性
    //是否登陆
    class var isLogin: Bool {
        
        return NSUserDefaults.standardUserDefaults().boolForKey("isLogin")
    }
    
    //获取用户对象
//    static var userAccount: UserModel? {
//        
//        return UserModel
//    }
    
    
    //获取accessToken
//    var accessToken: String? {
//        
//        //判断access_token是否有值
//        guard let token = userAccount!.token else{
//            return nil
//        }
//        
//        //执行到这里说明access_token有值
//        //判断access_token是否过期
//        let result = userAccount?.overDate?.compare(NSDate())
//        
//        //如果比较结果是降序说明没有过期
//        if result == NSComparisonResult.OrderedDescending{
//            
//            //返回access_token
//            return token
//            
//        }else{
//            
//            return nil
//        }
//    }
    
    //注册用户
    func normalAccountRegister(user: String, pass: String, finished: MineViewModelFinished) {
        
        //如果用户名为空，则弹出警告框并返回
        if user.isEmpty {
            WFShowHUD("注册帐号不可为空", status: WFStatusHUD.Failure)
            return
        }
        if pass.isEmpty && pass.characters.count < 6 {
            WFShowHUD("密码长度不可少于6位", status: WFStatusHUD.Failure)
            return
        }
        
        var parameters: [String: AnyObject]
        parameters = [
            "user": user,
            "pass": pass,
            "type": 1
        ]
        
        WFShowHUD("注册中...", status: WFStatusHUD.Waiting)
        WFNetwork.shareNetwork.WFPost(register_url, parameters: parameters) { (success, result, error) in
            
            if let result = result {
                
                let code = result["code"].intValue
                let info = result["info"].stringValue
                
                guard code == RETURN_CODE else {
                    self.WFShowHUD(info, status: WFStatusHUD.Failure)
                    return
                }
                
                guard let data = result["data"].dictionary else {
                    return
                }
                
                print(data)
                //self.model?.avatar = data["avatar"]?.stringValue
                self.saveAccount()
                self.WFHideHUD()
                finished(success: true)
            }
        }
    }
    
    //普通登陆
    func normalAccountLogin(user: String, pass: String, finished: MineViewModelFinished) {
        
        //如果用户名为空，则弹出警告框并返回
        if user.isEmpty {
            WFShowHUD("帐号不可为空", status: WFStatusHUD.Failure)
            return
        }
        if pass.isEmpty {
            WFShowHUD("密码不可为空", status: WFStatusHUD.Failure)
            return
        }
        
        var parameters: [String: AnyObject]
        parameters = [
            "user": user,
            "pass": pass
        ]
        WFShowHUD("登陆中...", status: WFStatusHUD.Waiting)
        WFNetwork.shareNetwork.WFPost(login_url, parameters: parameters) { (success, result, error) in
            
            if let result = result {
                
                let code = result["code"].intValue
                let info = result["info"].stringValue
                
                guard code == RETURN_CODE else {
                    self.WFShowHUD(info, status: WFStatusHUD.Failure)
                    return
                }
                
                guard let data = result["data"].dictionary else {
                    return
                }
                
                print(data)
                //self.model!.uid = data["uid"]!.intValue
                self.saveAccount()
                self.WFHideHUD()
                finished(success: true)
            }
        }
    }
    
    //第三方登陆
    
    
    //注销登陆
    func logout() {
        print("退出登陆")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isLogin")
    }
    
}
