//
//  WFProgress.swift
//  YouHua
//
//  Created by 高洋 on 16/7/1.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation
import SVProgressHUD

//枚举状体类型
enum WFStatusHUD: Int {
    case Waiting
    case Success
    case Failure
}

protocol WFProgress {
    
//    func WFShowHUD(title: String, status: WFStatusHUD)
//    func WFHideHUD()
}

extension WFProgress {
    
    func WFShowHUD(title: String, status: WFStatusHUD) {
        
        SVProgressHUD.showWithStatus(title)
        switch status {
            
            case .Waiting:
            
                SVProgressHUD.showWithStatus(title)
            case .Success:
                
                //SVProgressHUD.showWithStatus(title)
                WFHideHUD()
            case .Failure:
                
                //SVProgressHUD.showWithStatus(title)
                WFHideHUD()
        }
    }
    
    func WFHideHUD() {
        //控制弹框在1秒后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            SVProgressHUD.dismiss()
        }
    }
//    //感叹号
//    
//    [SVProgressHUD showInfoWithStatus:@"xxxxx."];
//    
//    //success
//    
//    [SVProgressHUD showSuccessWithStatus:@"Success!"];
//    
//    //error
//    
//    [SVProgressHUD showErrorWithStatus:@"Error"];
//    
//    文／文艺程序猿（简书作者）
//    原文链接：http://www.jianshu.com/p/1fece90af4a2
//    著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
//    //    func showHUD() {
//        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        hud.mode = MBProgressHUDMode.Indeterminate
//        hud.labelText = "数据加载中……"
//        hud.dimBackground = true
//    }
//    func hideHUD() {
//        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//    }
}