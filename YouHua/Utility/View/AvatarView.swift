//
//  AvatarView.swift
//  YouHua
//
//  Created by 高洋 on 16/8/20.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

protocol AvatarViewDelegate: NSObjectProtocol {
    func avatarView(didSelectedAvatarAtIndex row: Int)
}

enum AvatarSize: Int {
    case Large
    case Small
}

class AvatarView: UIView {

    weak var delegate: AvatarViewDelegate!
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    lazy var headView: UIImageView = {
        let temp = UIImageView()
        temp.layer.masksToBounds = true
        return temp
    }()
    
    lazy var nickLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(fontSize: 14)
        temp.textColor = Color_Title
        return temp
    }()
    
    lazy var shortLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(fontSize: 12)
        temp.textColor = Color_Tags
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
        
        //initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(avatarSize: AvatarSize, boxSize: CGFloat) {
        
        self.addSubview(headView)
        self.addSubview(nickLabel)
        self.addSubview(shortLabel)
        
        headView.layer.cornerRadius = boxSize / 2
        
        weak var weakSelf: AvatarView? = self
        headView.snp_makeConstraints { (make) in
            make.top.left.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.size.equalTo(boxSize)
        }
        
        switch avatarSize {
            case .Large:
                
                nickLabel.snp_makeConstraints { (make) in
                    make.top.equalTo(headView.snp_top).offset(0)
                    make.left.equalTo(headView.snp_right).offset(Margin_Width)
                    make.height.equalTo(boxSize / 2)
                }
                shortLabel.snp_makeConstraints { (make) in
                    make.left.equalTo(headView.snp_right).offset(Margin_Width)
                    make.bottom.equalTo(headView.snp_bottom).offset(0)
                    make.height.equalTo(boxSize / 2 - 2)
                }
            
            case .Small:
                
                nickLabel.snp_makeConstraints { (make) in
                    make.top.equalTo(weakSelf!).offset(0)
                    make.left.equalTo(headView.snp_right).offset(Margin_Width)
                    make.height.equalTo(boxSize)
                }
                shortLabel.snp_makeConstraints { (make) in
                    make.top.right.equalTo(weakSelf!).offset(UIEdgeInsetsMake(3, 0, 0, 0))
                    //make.right.equalTo(nickLabel.snp_right).offset(Margin_Width)
                    make.height.equalTo(boxSize - 3)
                }
        }
        
        headView.userInteractionEnabled = true
        let avatarTap = UITapGestureRecognizer(target: self, action: #selector(avatarAction(_:)))
        headView.addGestureRecognizer(avatarTap)
        
        nickLabel.userInteractionEnabled = true
        let nickTap = UITapGestureRecognizer(target: self, action: #selector(avatarAction(_:)))
        nickLabel.addGestureRecognizer(nickTap)
    }
    
    func avatarAction(gestRecognizer: UITapGestureRecognizer) {
        
        guard let view = gestRecognizer.view where delegate != nil else {
            return
        }
        delegate.avatarView(didSelectedAvatarAtIndex: view.tag)
    }
    
//    override func drawRect(rect: CGRect) {
//
//        let context: CGContextRef = UIGraphicsGetCurrentContext()! //获得处理的上下文
//        CGContextSetLineCap(context, .Square) //指定直线样式
//        CGContextSetLineWidth(context, 0.5) //直线宽度
//        CGContextSetRGBStrokeColor(context, 208/255, 208/255, 208/255, 1) //线的颜色
//        CGContextBeginPath(context)//开始绘制
//        CGContextMoveToPoint(context, 0, rect.size.height)//起点坐标
//        CGContextAddLineToPoint(context, rect.size.width, rect.size.height)//终点坐标
//        CGContextStrokePath(context)//绘制完成
//    }
}
