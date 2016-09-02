//
//  ControllerExtension.swift
//  YouHua
//
//  Created by 高洋 on 16/7/1.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

extension UIViewController {
    //设置导航Item
    func setNavigationItem(title title: String, selector: Selector, isRight: Bool) {
        var item: UIBarButtonItem!
        
        //标题 图片OR文字
        if title.hasSuffix("png") {
            item = UIBarButtonItem(image: UIImage(named: title), style: .Plain, target: self, action: selector)
            item.tintColor = UIColor.grayColor()
        } else {
            item = UIBarButtonItem(title: title, style: .Plain, target: self, action: selector)
            //item.tintColor = UIColor.grayColor()
            let color: UIColor = UIColor.grayColor()
            let font: UIFont = UIFont(name: FONT_NAME, size: 14)!
            item.setTitleTextAttributes([NSForegroundColorAttributeName: color, NSFontAttributeName: font], forState: .Normal)
        }
        
        //按钮位置
        if isRight {
            navigationItem.rightBarButtonItem = item
        } else {
            navigationItem.leftBarButtonItem = item
        }
    }
    
    //返回上一个视图
    func backViewAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    //关闭当前视图
    func closeViewAction() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}