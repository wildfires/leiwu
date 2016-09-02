//
//  FindModel.swift
//  YouHua
//
//  Created by 高洋 on 16/8/25.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

class FindModel: NSObject {
    
    var cover: String
    
    init(dict: [String: AnyObject]) {
        
        self.cover = dict["url"] as! String
    }
}