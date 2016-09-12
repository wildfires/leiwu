//
//  ShareView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/28.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

protocol ShareViewDelegate: NSObjectProtocol {
    
    func shareViewDidSelectedAtIndex(didSelectedAtIndex index: Int)
}

class ShareView: UIView {

    weak var delegate: ShareViewDelegate!
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    let shareHeight: CGFloat = 80 + 80
    var sharePicArr: NSArray = ["Share_WeChatSessionIcon_70x70_","Share_WeChatTimelineIcon_70x70_","Share_WeiboIcon_70x70_","Share_QQIcon_70x70_","Share_QzoneIcon_70x70_"]
    var shareTitArr: NSArray = ["微信","朋友圈","微博","QQ好友","QQ空间"]
    
    
    var btnSize: CGSize = CGSize(width: 60, height: 70)
    
    //var btnRow: Int = 2 //行 一行时不设置
    var btnCol: Int = 5 //列
    var btnMargin: CGFloat = 0 //间距
    var btnCount: Int = 5
    
    lazy var shareBgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = RGBA(red: 0, green: 0, blue: 0, alpha: 0.5)
        return temp
    }()
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "分享给好友"
        temp.font = UIFont(name: FONT_NAME, size: 14)
        temp.textAlignment = .Center
        return temp
    }()
    
    lazy var cancelButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("取消", forState: .Normal)
        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 14)
        temp.setTitleColor(UIColor.blackColor(), forState: .Normal)
        temp.addTarget(self, action: #selector(closeViewAction), forControlEvents: .TouchUpInside)
        temp.backgroundColor = RGBA(red: 244, green: 245, blue: 249, alpha: 1)
        return temp
    }()
    
    lazy var shareBoxView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.whiteColor()
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
        
        btnMargin = (VIEW_WIDTH - btnSize.width * CGFloat(btnCount)) / CGFloat(btnCount + 1)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
        self.addSubview(shareBgView)
        self.addSubview(shareBoxView)
        shareBoxView.addSubview(titleLabel)
        shareBoxView.addSubview(cancelButton)
        
        shareBgView.frame = CGRect(x: 0, y: 0, width: VIEW_WIDTH, height: VIEW_HEIGHT)
        titleLabel.frame = CGRect(x: 0, y: 0, width: VIEW_WIDTH, height: 40)
        shareBoxView.frame = CGRect(x: 0, y: VIEW_HEIGHT, width: VIEW_WIDTH, height: shareHeight)
        cancelButton.frame = CGRect(x: 0, y: shareHeight - 40, width: VIEW_WIDTH, height: 40)
        
        for index in 0..<btnCount {
            
            let currentCol: Int = index % btnCol + 1 //当前列
            //let currentRow: Int = index / btnRow //当前行
            let btnX: CGFloat = CGFloat(index) * btnSize.width + CGFloat(currentCol) * btnMargin
            let btnY: CGFloat = 40 //CGFloat(currentRow) * (btnMargin + btnSize.height)
            
            let shareBotton: UIButton = UIButton(image: sharePicArr[index] as? String, title: shareTitArr[index] as? String, size: CGSize(width: btnSize.width + btnMargin, height: btnSize.height), font: UIFont(name: FONT_NAME, size: 12), color: UIColor.blackColor())
            shareBotton.frame = CGRect(x: btnX, y: btnY, width: btnSize.width, height: btnSize.height)
            shareBoxView.addSubview(shareBotton)
        }
        
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(closeViewAction))
        shareBgView.addGestureRecognizer(bgTap)
        
        weak var weakSelf: ShareView? = self
        UIView.animateWithDuration(0.3) { 
            
            weakSelf!.shareBoxView.frame = CGRect(x: 0, y: weakSelf!.VIEW_HEIGHT - weakSelf!.shareHeight, width: weakSelf!.VIEW_WIDTH, height: weakSelf!.shareHeight)
        }
    }

    func showInView() {
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    
    func shareAction(button: UIButton) {
        
        weak var weakSelf: ShareView? = self
        UIView.animateWithDuration(0.3, animations: {
            
            weakSelf!.backgroundColor = UIColor.clearColor()
            weakSelf!.shareBoxView.frame = CGRect(x: 0, y: weakSelf!.VIEW_HEIGHT, width: weakSelf!.VIEW_WIDTH, height: weakSelf!.shareHeight)
        }) { (finished: Bool) in
            
            if weakSelf!.delegate != nil {
                weakSelf!.delegate.shareViewDidSelectedAtIndex(didSelectedAtIndex: button.tag)
            }
            weakSelf!.removeFromSuperview()
        }
    }
    
    func closeViewAction() {
        
        weak var weakSelf: ShareView? = self
        UIView.animateWithDuration(0.3, animations: {
            
            weakSelf!.backgroundColor = UIColor.clearColor()
            weakSelf!.shareBoxView.frame = CGRect(x: 0, y: weakSelf!.VIEW_HEIGHT, width: weakSelf!.VIEW_WIDTH, height: weakSelf!.shareHeight)
        }) { (finished: Bool) in
            
            weakSelf!.removeFromSuperview()
        }
    }
    
//    override func drawRect(rect: CGRect) {
//        
//        let context: CGContextRef = UIGraphicsGetCurrentContext()! //获得处理的上下文
//        CGContextSetLineCap(context, .Square) //指定直线样式
//        CGContextSetLineWidth(context, 0.5) //直线宽度
//        CGContextSetRGBStrokeColor(context, 0/255, 0/255, 100/255, 1) //线的颜色
//        CGContextBeginPath(context)//开始绘制
//        CGContextMoveToPoint(context, 0, rect.size.height - 40)//起点坐标
//        CGContextAddLineToPoint(context, rect.size.width - 16, rect.size.height - 40)//终点坐标
//        CGContextStrokePath(context)//绘制完成
//    }
}
