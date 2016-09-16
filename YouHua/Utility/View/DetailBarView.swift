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
    func detailBarView(didSelectedAtIndex row: Int, didSelectedAtTag tag: Int)
}
class DetailBarView: UIView {
    
    weak var delegate: DetailBarViewDelegate!
    var rowID: Int = 0
    
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
    
//    lazy var shareButton: UIButton = {
//        let temp = UIButton(type: UIButtonType.Custom)
//        temp.setImage(UIImage(named: "timeline_icon_retweet"), forState: .Normal)
//        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        temp.titleLabel?.font = UIFont(fontSize: 12)
//        temp.setTitle("分享", forState: .Normal)
//        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
//        temp.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        return temp
//    }()//分享
//    
//    lazy var praiseButton: UIButton = {
//        let temp = UIButton(type: UIButtonType.Custom)
//        temp.setImage(UIImage(named: "timeline_icon_unlike"), forState: .Normal)
//        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        temp.titleLabel?.font = UIFont(fontSize: 12)
//        temp.setTitle("赞", forState: .Normal)
//        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
//        temp.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        return temp
//    }()//赞美
//    
//    lazy var discussButton: UIButton = {
//        let temp = UIButton(type: UIButtonType.Custom)
//        temp.setImage(UIImage(named: "timeline_icon_comment"), forState: .Normal)
//        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        temp.titleLabel?.font = UIFont(fontSize: 12)
//        temp.setTitle("评论", forState: .Normal)
//        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
//        return temp
//    }()//讨论
    
    lazy var praiseButton: UIButton = {
        let temp = UIButton(image: "icon_like_", title: "0", font: UIFont(fontSize: 12), color: Color_Gray)
        temp.addTarget(self, action: #selector(barButtonAction(_:)), forControlEvents: .TouchUpInside)
        return temp
    }()//赞/喜好
    lazy var discussButton: UIButton = {
        let temp = UIButton(image: "icon_msg_", title: "0", font: UIFont(fontSize: 12), color: Color_Gray)
        temp.addTarget(self, action: #selector(barButtonAction(_:)), forControlEvents: .TouchUpInside)
        return temp
    }()//评论
    lazy var shareButton: UIButton = {
        let temp = UIButton(image: "icon_share_", title: "分享", font: UIFont(fontSize: 12), color: Color_Gray)
        temp.addTarget(self, action: #selector(barButtonAction(_:)), forControlEvents: .TouchUpInside)
        return temp
    }()//分享
    
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
        let Margin_Top: CGFloat = Margin_Height / 2
        let Margin_Left: CGFloat = 2 * Margin_Width
        backButton.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(Margin_Top, Margin_Width, Margin_Top, 0))
        }
        
        shareButton.snp_makeConstraints { (make) in
            make.top.right.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(Margin_Top, 0, Margin_Top, Margin_Width))
        }
        discussButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(Margin_Top, 0, Margin_Top, 0))
            make.right.equalTo(shareButton.snp_left).offset(-Margin_Left)
        }
        praiseButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(Margin_Top, 0, Margin_Top, 0))
            make.right.equalTo(discussButton.snp_left).offset(-Margin_Left)
        }
    }
    
    //返回事件
    func backViewAction() {
        
        if delegate != nil {
            delegate.backViewAction()
        }
    }
    
    func barButtonAction(button: UIButton) {
        
        guard delegate != nil else {
            return
        }
        delegate.detailBarView(didSelectedAtIndex: rowID, didSelectedAtTag: button.tag)
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
