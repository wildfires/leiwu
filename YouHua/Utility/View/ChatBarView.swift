//
//  ChatBarView.swift
//  YouHua
//
//  Created by 高洋 on 16/6/29.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class ChatBarView: UIView {

    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    let buttonSize: CGSize = CGSize(width: 34, height: 34)
    lazy var voiceButton: UIButton = {
        
        let temp = UIButton(type: UIButtonType.Custom)
        temp.setImage(UIImage(named: "ToolViewInputVoice"), forState: .Normal)
        temp.setImage(UIImage(named: "ToolViewInputVoiceHL"), forState: .Highlighted)
        //emotionButton.addTarget(taget, action: emotionSelector, forControlEvents: .TouchUpInside)
        //temp.setBackgroundImage(UIImage(named: "chat_bottom_voice_press"), forState: .Normal)
        
        return temp
    }()//切换语言
    lazy var audioButton: UIButton = {
        
        let temp = UIButton(type: UIButtonType.Custom)
        temp.setTitle("按住 说话", forState: .Normal)
        temp.titleLabel?.font = UIFont(fontSize: 14)
        //temp.backgroundColor = UIColor.grayColor()
        temp.layer.borderColor = UIColor.lightGrayColor().CGColor
        temp.layer.borderWidth = 0.5
        temp.layer.cornerRadius = 5
        temp.setTitleColor(Color_Black, forState: .Normal)
        //recordButton.layer.masksToBounds = true
        temp.hidden = true
        return temp
    }()//语音按钮
    lazy var textView: UITextView = {
        
        let temp = UITextView()
        //temp.layer.borderColor = RGBA(red: 128, green: 132, blue: 138, alpha: 0.5).CGColor
        temp.layer.borderColor = UIColor.lightGrayColor().CGColor
        temp.layer.borderWidth = 0.5
        temp.layer.cornerRadius = 5
        temp.returnKeyType = .Send
        return temp
    }()
    lazy var faceButton: UIButton = {
        
        let temp = UIButton()
        temp.setImage(UIImage(named: "ToolViewEmotion"), forState: .Normal)
        temp.setImage(UIImage(named: "ToolViewEmotionHL"), forState: .Highlighted)
        return temp
    }()//表情按钮
    lazy var moreButton: UIButton = {
        
        let temp = UIButton()
        temp.setImage(UIImage(named: "TypeSelectorBtn_Black"), forState: .Normal)
        temp.setImage(UIImage(named: "TypeSelectorBtnHL_Black"), forState: .Highlighted)
        return temp
    }()//更多
    
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
        
        //设置bar背景颜色
        self.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        //设置顶部线条
//        let line: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: VIEW_WIDTH, height: 0.5))
//        line.backgroundColor = UIColor.lightGrayColor()
//        self.addSubview(line)
        
        self.addSubview(voiceButton)
        self.addSubview(audioButton)
        self.addSubview(textView)
        self.addSubview(faceButton)
        self.addSubview(moreButton)
        
        weak var weakSelf: ChatBarView? = self
        voiceButton.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 5, 8, 0))
            make.size.equalTo(weakSelf!.buttonSize)
        }
        
        textView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 0, 8, 0))
            make.left.equalTo(voiceButton.snp_right).offset(3)
            make.right.equalTo(faceButton.snp_left).offset(-3)
            make.height.equalTo(weakSelf!.buttonSize.height)
        }
        
        audioButton.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 0, 8, 0))
            make.left.equalTo(voiceButton.snp_right).offset(3)
            make.right.equalTo(faceButton.snp_left).offset(-3)
            make.height.equalTo(weakSelf!.buttonSize.height)
        }
        
        faceButton.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 0, 8, 0))
            make.right.equalTo(moreButton.snp_left).offset(0)
            make.size.equalTo(weakSelf!.buttonSize)
        }
        
        moreButton.snp_makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(8, 0, 8, 5))
            make.size.equalTo(weakSelf!.buttonSize)
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()! //获得处理的上下文
        CGContextSetLineCap(context, .Square) //指定直线样式
        CGContextSetLineWidth(context, 0.5) //直线宽度
        CGContextSetRGBStrokeColor(context, 0/255, 0/255, 100/255, 1) //线的颜色
        CGContextBeginPath(context)//开始绘制
        CGContextMoveToPoint(context, 0, 0)//起点坐标
        CGContextAddLineToPoint(context, rect.size.width, 0)//终点坐标
        CGContextStrokePath(context)//绘制完成
    }
}
