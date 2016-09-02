//
//  HomeModel.swift
//  YouHua
//
//  Created by 高洋 on 16/7/5.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

struct HomeModel {
    
    var did: Int
    var avatar: String
    var nickname: String
    var cover: String
    var photo: Int
    var content: String
    var comments: Int
    var likes: Int
    var video: String
    var type: String
    var dateline: Int
    //var my_thumbnailUrls = [ImageUrlModel]()
    
    /**
     字典数据封装成数据模型
     - parameter dice: 字典数据源
     - returns: 数据模型
     */
    init(dict: [String: AnyObject]) {
        
        //print(dict)
        self.did = dict["aid"] as? Int ?? 0
        let avatar = dict["avatar"] as? String ?? ""
        self.avatar = API_RUL + avatar
        self.nickname = dict["nick"] as? String ?? ""
        let cover = dict["cover"] as? String ?? ""
        self.cover = API_RUL + cover
        self.photo = dict["photo"] as? Int ?? 0
        self.content = dict["content"] as? String ?? ""
        self.comments = dict["comments"] as? Int ?? 0
        self.likes = dict["likes"] as? Int ?? 1
        self.video = dict["video"] as? String ?? ""
        self.type = dict["type"] as! String
        self.dateline = dict["dateline"] as? Int ?? 0
        
        //字典中还有数组，直接转模型
//        if let imageDict = dict[key_thumbnailUrls] as? [[String:String]] {
//            for item in imageDict {
//                my_thumbnailUrls.append(ImageUrlModel(dict: item))
//            }
//            
//        }
        //my_thumbnailUrls = dict[key_thumbnailUrls] as? [[String:String]] ?? [["":""]]
    }
}