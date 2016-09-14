//
//  FindViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/7/30.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class FindViewModel: NSObject {
    
    //var bannerArray: [FindModel] = []
    var bannerArray: NSArray?
    
    
    func networkRequestData(finished: HomeViewModelFinished) {
        
        let params: [String: AnyObject] = [
            "act": "banner"
        ]
        
        
        WFNetwork.shareNetwork.WFGET(banner_url, parameters: params) { (success, result, error) in
            
            guard let result = result where success == true else {
                
                print(success, error, params)
                finished(success: false)
                return
            }
            
            let tempArray = result.arrayObject as! [[String : AnyObject]]
            
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