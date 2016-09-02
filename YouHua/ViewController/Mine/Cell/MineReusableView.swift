//
//  MineReusableView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/22.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class MineReusableView: UICollectionReusableView {
    
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    lazy var avatarView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        temp.layer.cornerRadius = 35
        temp.image = UIImage(named: "img_04")
        temp.layer.borderColor = UIColor.grayColor().CGColor
        temp.layer.borderWidth = 0.5
        return temp
    }()
    
    lazy var sexView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .Center
        temp.clipsToBounds = true
        temp.layer.cornerRadius = 8
        //temp.backgroundColor = RGBA(red: 226, green: 49, blue: 65, alpha: 1)
        //temp.image = UIImage(named: "")
        return temp
    }()
    
//    lazy var nickNameLabel: UILabel = {
//        let temp = UILabel()
//        temp.font = UIFont(name: FONT_NAME, size: 14)
//        temp.text = "小羊罢课"
//        temp.textAlignment = .Center
//        return temp
//    }()
    
    lazy var followAndEditButton: UIButton = {
        let temp = UIButton()
        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 12)
        temp.setTitle("+ 关注", forState: .Normal)
        temp.setTitleColor(RGBA(red: 22, green: 163, blue: 95, alpha: 1), forState: .Normal)
        temp.layer.borderColor = RGBA(red: 22, green: 163, blue: 95, alpha: 1).CGColor
        temp.layer.borderWidth = 0.5
        temp.layer.cornerRadius = 3
        //temp.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        return temp
    }()
    
    //图集
    lazy var trendsView: mineBoxView = {
        let temp = mineBoxView(title: "动态", number: "0")
        //temp.backgroundColor = UIColor.grayColor()
        return temp
    }()
    //关注
    lazy var followsView: mineBoxView = {
        let temp = mineBoxView(title: "关注", number: "0")
        //temp.backgroundColor = UIColor.blueColor()
        return temp
    }()
    //粉丝
    lazy var fansView: mineBoxView = {
        let temp = mineBoxView(title: "粉丝", number: "0")
        //temp.backgroundColor = UIColor.grayColor()
        return temp
    }()
    
    //地址
    lazy var addressButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "compose_locatebutton_ready"), forState: .Normal)
        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 12)
        //temp.setTitle("四川 成都", forState: .Normal)
        temp.setTitleColor(UIColor.grayColor(), forState: .Normal)
        
        //temp.backgroundColor = UIColor.brownColor()
        return temp
    }()
    //签名
    lazy var signLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: FONT_NAME, size: 12)
        temp.numberOfLines = 0
        //temp.setLineSpacing
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()! //获得处理的上下文
        CGContextSetLineCap(context, .Square) //指定直线样式
        CGContextSetLineWidth(context, 0.5) //直线宽度
        CGContextSetRGBStrokeColor(context, 0/255, 0/255, 100/255, 1) //线的颜色
        CGContextBeginPath(context)//开始绘制
        
        CGContextMoveToPoint(context, 0, rect.size.height)//起点坐标
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height)//终点坐标
        
        //CGContextMoveToPoint(context, 0, rect.size.height - 40)//起点坐标
        //CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 40)//终点坐标
        
        CGContextStrokePath(context)//绘制完成
    }
    
    func initHeaderView() {
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(avatarView)
        self.addSubview(sexView)
        //self.addSubview(nickNameLabel)
        
        self.addSubview(trendsView)
        self.addSubview(followsView)
        self.addSubview(fansView)
        
        self.addSubview(followAndEditButton)
        self.addSubview(addressButton)
        self.addSubview(signLabel)
        
        weak var weakSelf: MineReusableView? = self
        avatarView.snp_makeConstraints { (make) in
            make.top.left.equalTo(weakSelf!).inset(UIEdgeInsetsMake(16, 16, 0, 0))
            make.size.equalTo(70)
        }
        
        sexView.snp_makeConstraints { (make) in
            make.bottom.right.equalTo(avatarView).inset(UIEdgeInsetsMake(0, 0, 3, 3))
            make.size.equalTo(16)
        }
        
        
//        nickNameLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(weakSelf!).offset(16)
//            make.left.equalTo(avatarView.snp_right).offset(16)
//            make.height.equalTo(30)
//        }
        
        trendsView.snp_makeConstraints { (make) in
            make.top.equalTo(weakSelf!).offset(16)
            make.left.equalTo(avatarView.snp_right).offset(40)
            //make.right.equalTo(followsView.snp_left).offset(0)
            make.size.equalTo(CGSize(width: (VIEW_WIDTH - 32 - 70 - 40) / 3, height: 30))
        }
        followsView.snp_makeConstraints { (make) in
            make.top.equalTo(weakSelf!).offset(16)
            make.left.equalTo(trendsView.snp_right).offset(0)
            //make.right.equalTo(fansView.snp_left).offset(0)
            make.size.equalTo(trendsView)
        }
        fansView.snp_makeConstraints { (make) in
            make.top.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(16, 0, 0, 16))
            //make.left.equalTo(followsView.snp_right).offset(0)
            
            make.size.equalTo(trendsView)
        }
        
        followAndEditButton.snp_makeConstraints { (make) in
            make.right.equalTo(weakSelf!).offset(-16)
            make.bottom.equalTo(avatarView.snp_bottom).offset(0)
            make.left.equalTo(avatarView.snp_right).offset(40)
            make.height.equalTo(30)
        }
        
        addressButton.snp_makeConstraints { (make) in
            make.top.equalTo(avatarView.snp_bottom).offset(8)
            make.left.equalTo(weakSelf!).offset(16)
        }
        
        signLabel.snp_makeConstraints { (make) in
            make.top.equalTo(addressButton.snp_bottom).offset(8)
            make.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 16, 0, 16))
        }
    }
}

class mineBoxView: UIView {
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: FONT_NAME, size: 10)
        temp.textColor = UIColor.grayColor()
        temp.textAlignment = .Center
        return temp
    }()
    
    lazy var numberLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: FONT_NAME, size: 12)
        temp.textColor = UIColor.blackColor()
        temp.textAlignment = .Center
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        self.addSubview(numberLabel)
        
        weak var weakSelf: mineBoxView? = self
        titleLabel.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        numberLabel.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.left.bottom.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    init(title: String, number: String) {
        self.init()
        
        titleLabel.text = title
        numberLabel.text = number
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
