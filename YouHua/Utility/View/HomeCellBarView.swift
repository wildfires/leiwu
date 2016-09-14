//
//  HomeCellBarView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/25.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeCellBarViewDelegate: NSObjectProtocol {
    
    //func homeCellBarViewDidSelectedAvartarWithName()
    func homeCellBarViewDidSelectedButton(didSelectedAtIndex row: Int, didSelectedAtTag tag: Int)
}

class HomeCellBarView: UIView {
    
    weak var delegate: HomeCellBarViewDelegate!
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    var rowId: Int = 0
    
    lazy var praiseButton: UIButton = {
        let temp = UIButton(image: "ic_me_item_collection_topic_20x20_", title: "0", font: UIFont(fontSize: 12), color: Color_Gray)
        temp.addTarget(self, action: #selector(barButtonAction(_:)), forControlEvents: .TouchUpInside)
        return temp
    }()//赞/喜好
    lazy var discussButton: UIButton = {
        let temp = UIButton(image: "ic_me_item_message_20x20_", title: "0", font: UIFont(fontSize: 12), color: Color_Gray)
        temp.addTarget(self, action: #selector(barButtonAction(_:)), forControlEvents: .TouchUpInside)
        return temp
    }()//评论
    lazy var shareButton: UIButton = {
        let temp = UIButton(image: "timeline_icon_retweet", title: "分享", font: UIFont(fontSize: 12), color: Color_Gray)
        temp.addTarget(self, action: #selector(barButtonAction(_:)), forControlEvents: .TouchUpInside)
        return temp
    }()//分享
    
    lazy var dateButton: UIButton = {
        let temp = UIButton(image: "time_commodity_night_16x16_", title: "时间", font: UIFont(fontSize: 12), color: Color_Gray)
        temp.userInteractionEnabled = false
        return temp
    }()//时间
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
        
        initVew()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initVew() {
        
        self.addSubview(praiseButton)
        self.addSubview(discussButton)
        self.addSubview(shareButton)
        self.addSubview(dateButton)
        
        weak var weakSelf: HomeCellBarView? = self
        praiseButton.snp_makeConstraints { (make) in
            make.top.left.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        discussButton.snp_makeConstraints { (make) in
            make.top.equalTo(weakSelf!).offset(0)
            make.left.equalTo(praiseButton.snp_right).offset(Margin_Width)
        }
        shareButton.snp_makeConstraints { (make) in
            make.top.equalTo(weakSelf!).offset(0)
            make.left.equalTo(discussButton.snp_right).offset(Margin_Width)
        }
        
        dateButton.snp_makeConstraints { (make) in
            make.top.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func barButtonAction(button: UIButton) {
        
        if delegate != nil {
            delegate.homeCellBarViewDidSelectedButton(didSelectedAtIndex: rowId, didSelectedAtTag: button.tag)
        }
    }
    
//    override func drawRect(rect: CGRect) {
//        
//        let context: CGContextRef = UIGraphicsGetCurrentContext()! //获得处理的上下文
//        CGContextSetLineCap(context, .Square) //指定直线样式
//        CGContextSetLineWidth(context, 0.5) //直线宽度
//        CGContextSetRGBStrokeColor(context, 207/255, 207/255, 207/255, 1) //线的颜色
//        CGContextBeginPath(context)//开始绘制
//        CGContextMoveToPoint(context, 0, 0)//起点坐标
//        CGContextAddLineToPoint(context, rect.size.width, 0)//终点坐标
//        CGContextStrokePath(context)//绘制完成
//    }
}
