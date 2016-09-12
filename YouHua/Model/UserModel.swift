//
//  UserModel.swift
//  YouHua
//
//  Created by 高洋 on 16/9/5.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

struct UserModel {
    
//  MARK: Attributes
    var token: String?
//    var expiration: String
    var uid: Int?
    var nick: String?
    var avatar: String?
//    var mobile: String
//    var email: String
//    var sex: Int
//    var regTime: String
//    var follows: Int
//    var fans: Int
    
    static var isLogin: Bool {
        
        return true
    }
    
    /**
     字典数据封装成数据模型
     - parameter dice: 字典数据源
     - returns: 数据模型
     */
    init(dict: [String: AnyObject]) {
        
        self.uid = dict["uid"] as? Int ?? 0
        self.token = dict["token"] as? String ?? ""
        self.nick = dict["nick"] as? String ?? ""
        let avatar = dict["avatar"] as? String ?? ""
        self.avatar = API_RUL + avatar
    }
    
    internal func use() -> UserModel {
        
        return self
    }
    /**
     普通账号登录
     
     - parameter type:     登录类型
     - parameter username: 用户名/邮箱/手机号码
     - parameter password: 密码
     - parameter finished: 完成回调
     */
//    func normalAccountLogin(type: String, username: String, password: String, finished: (success: Bool, tip: String) -> ()) {
//        
////        let parameters: [String : AnyObject] = [
////            "identifier" : username,
////            "credential" : password,
////            "type" : type
////        ]
////        
////        JFNetworkTools.shareNetworkTool.post(LOGIN, parameters: parameters) { (success, result, error) in
////            
////            guard let result = result else {
////                finished(success: false, tip: "您的网络不给力哦")
////                return
////            }
////            
////            if result["status"] == "success" {
////                let account = JFAccountModel(dict: result["result"].dictionaryObject!)
////                account.saveUserInfo()
////                finished(success: true, tip: "登录成功")
////            } else {
////                finished(success: false, tip: result["message"].stringValue)
////            }
////            
////        }
//    }
//    
//    /**
//     第三方登录
//     
//     - parameter type:     类型 qq weibo
//     - parameter openid:   uid
//     - parameter token:    token
//     - parameter nickname: 昵称
//     - parameter avatar:   头像
//     - parameter sex:      性别 0:女 1:男
//     - parameter finished: 完成回调
//     */
//    func thirdAccountLogin(type: String, openid: String, token: String, nickname: String, avatar: String, sex: Int, finished: (success: Bool, tip: String) -> ()) {
//        
////        let parameters: [String : AnyObject] = [
////            "type" : type,
////            "identifier" : openid,
////            "token" : token,
////            "nickname" : nickname,
////            "avatar" : avatar,
////            "sex" : sex
////        ]
////        
////        JFNetworkTools.shareNetworkTool.post(LOGIN, parameters: parameters) { (success, result, error) in
////            
////            guard let result = result else {
////                finished(success: false, tip: "您的网络不给力哦")
////                return
////            }
////            
////            if result["status"] == "success" {
////                let account = JFAccountModel(dict: result["result"].dictionaryObject!)
////                account.saveUserInfo()
////                finished(success: true, tip: "登录成功")
////            } else {
////                finished(success: false, tip: result["message"].stringValue)
////            }
////            
////        }
//    }
    
    
}