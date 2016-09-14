//
//  DetailBarView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/7.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

protocol DetailBarViewDelegate: NSObjectProtocol {
    
    func backViewAction()
    
}

class DetailBarView: UIView {
    
    weak var delegate: DetailBarViewDelegate!
    
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    lazy var backButton: UIButton = {
        let temp = UIButton(type: UIButtonType.Custom)
        temp.setImage(UIImage(named: "ic_nav_second_back_normal_17x17_"), forState: .Normal)
//        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 12)
//        temp.setTitle("返回", forState: .Normal)
//        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
//        temp.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        return temp
    }()//返回
    
    lazy var shareButton: UIButton = {
        let temp = UIButton(type: UIButtonType.Custom)
        temp.setImage(UIImage(named: "timeline_icon_retweet"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        temp.titleLabel?.font = UIFont(fontSize: 12)
        temp.setTitle("分享", forState: .Normal)
        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        temp.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        return temp
    }()//分享
    
    lazy var praiseButton: UIButton = {
        let temp = UIButton(type: UIButtonType.Custom)
        temp.setImage(UIImage(named: "timeline_icon_unlike"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        temp.titleLabel?.font = UIFont(fontSize: 12)
        temp.setTitle("赞", forState: .Normal)
        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        temp.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        return temp
    }()//赞美
    
    lazy var discussButton: UIButton = {
        let temp = UIButton(type: UIButtonType.Custom)
        temp.setImage(UIImage(named: "timeline_icon_comment"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        temp.titleLabel?.font = UIFont(fontSize: 12)
        temp.setTitle("评论", forState: .Normal)
        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        return temp
    }()//讨论
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        //移除视图
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(backButton)
        self.addSubview(shareButton)
        self.addSubview(praiseButton)
        self.addSubview(discussButton)
        
        backButton.addTarget(self, action: #selector(backViewAction), forControlEvents: .TouchUpInside)
        
        weak var weakSelf: DetailBarView? = self
        backButton.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 8, 8, 0))
        }
        discussButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 0, 8, 8))
        }
        praiseButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 0, 8, 0))
            make.right.equalTo(discussButton.snp_left).offset(-8)
        }
        shareButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 0, 8, 0))
            make.right.equalTo(praiseButton.snp_left).offset(-8)
        }
    }
    
    //返回事件
    func backViewAction() {
        
        if delegate != nil {
            delegate.backViewAction()
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()! //获得处理的上下文
        CGContextSetLineCap(context, .Square) //指定直线样式
        CGContextSetLineWidth(context, 0.5) //直线宽度
        CGContextSetRGBStrokeColor(context, 214/255, 214/255, 214/255, 1) //线的颜色
        CGContextBeginPath(context)//开始绘制
        CGContextMoveToPoint(context, 0, 0)//起点坐标
        CGContextAddLineToPoint(context, rect.size.width, 0)//终点坐标
        CGContextStrokePath(context)//绘制完成
    }

}
