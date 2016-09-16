//
//  DetailViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/9/15.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias DetailViewModelDataFinished = (result: [HomeModel]) -> ()

class DetailViewModel: NSObject {

    var contentArray = [HomeModel]()
    var commentArray = [HomeModel]()
    
    var cellContentNumberOfRows: Int {
        
        return contentArray.count
    }
    
    var cellCommentNumberOfRows: Int {
        
        return commentArray.count
    }
    
    //详情页
    func loadContentData(id: Int, finished: DetailViewModelDataFinished) {
        
        let params: [String: AnyObject] = [
            "id": id,
            "page": id
        ]
        
        //weak var weakSelf: HomeViewModel? = self
        WFNetwork.shareNetwork.WFGET(home_url, parameters: params) { (success, result, error) in
            
            guard let result = result where success == true else {
                print(success, error, params)
                return
            }
            
            guard let data = result.arrayObject else {
                return
            }
            
            var tempData = [HomeModel]()
            tempData.append(HomeModel(dict: data[id] as! [String : AnyObject]))
            finished(result: tempData)
        }
    }
    
    //评论列表
    func loadCommentData(id: Int, finished: DetailViewModelDataFinished) {
        
        let params: [String: AnyObject] = [
            "id": id,
            "page": id
        ]
        
        //weak var weakSelf: HomeViewModel? = self
        WFNetwork.shareNetwork.WFGET(home_url, parameters: params) { (success, result, error) in
            
            guard let result = result where success == true else {
                print(success, error, params)
                return
            }
            
            guard let data = result.arrayObject else {
                return
            }
            
            var tempData = [HomeModel]()
            for dict in data {
                tempData.append(HomeModel(dict: dict as! [String : AnyObject]))
            }
            finished(result: tempData)
        }
    }
}
