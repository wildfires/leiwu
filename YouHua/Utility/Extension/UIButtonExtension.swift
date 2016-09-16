//
//  UIButtonExtension.swift
//  YouHua
//
//  Created by 高洋 on 16/7/16.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

extension UIButton {
    
//    convenience init(title: String?, imageName: String?, target: AnyObject? ,selector: Selector?, font: UIFont?, titleColor: UIColor?) {
//        self.init()
//        if let imageN = imageName {
//            setImage(UIImage(named:imageN), forState: .Normal)
//        }
//        setTitleColor(titleColor, forState: .Normal)
//        titleLabel?.font = font
//        setTitle(title, forState: .Normal)
//        if let sel = selector {
//            addTarget(target, action: sel, forControlEvents: .TouchUpInside)
//        }
//        
//    }
    
    //左图标＋右文字
    convenience init(image: String?, title: String?, font: UIFont?, color: UIColor?) {
        self.init()
        
        if let imageName = image {
            setImage(UIImage(named: imageName), forState: .Normal)
        }
        setTitleColor(color, forState: .Normal)
        titleLabel?.font = font
        setTitle(title, forState: .Normal)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //上图标＋下文字
    convenience init(image: String?, title: String?, size: CGSize?, font: UIFont?, color: UIColor?) {
        self.init()
        
        if let imageName = image {
            setImage(UIImage(named: imageName), forState: .Normal)
        }
        setTitleColor(color, forState: .Normal)
        titleLabel?.font = font
        titleLabel?.textAlignment = .Center
        setTitle(title, forState: .Normal)
        imageView?.contentMode = .ScaleAspectFit
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 27, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: (size?.height)! - 30, left: -(size?.width)!, bottom: 0, right: 0)
    }
}







