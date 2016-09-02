//
//  FindViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/7/30.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class FindViewModel: NSObject, WFNetwork {
    
    //var bannerArray: [FindModel] = []
    var bannerArray: NSArray?
    
    
    func networkRequestData(finished: HomeViewModelFinished) {
        
        var parameters: [String: AnyObject]
        
        parameters = [
            "act": "banner"
        ]
        
        WFGet(banner_url, parameters: parameters) { (success, result, error) in
            
            guard let result = result where result["code"] == 200 else {
                
                print(success, error, parameters)
                finished(success: false)
                return
            }
            
            let tempArray = result["data"].arrayObject as! [[String : AnyObject]]
                
//                for dict in tempArray {
//                    self.bannerArray.append(FindModel(dict: dict as! [String : AnyObject]))
//                }
            
            let AdArray = tempArray.map({ (AD) -> String in
                
                return AD["url"] as! String
            })
            self.bannerArray = AdArray
            finished(success: true)
            
        }
    }
    
}