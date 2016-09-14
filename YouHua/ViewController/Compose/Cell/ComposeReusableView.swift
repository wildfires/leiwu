//
//  ComposeReusableView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/10.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

enum ComposeViewType: Int {
    case Header
    case Footer
}

class ComposeReusableView: UICollectionReusableView, UITextViewDelegate {
    
    lazy var textView: UITextView = {
        let temp = UITextView()
        temp.font = UIFont(fontSize: 14)
        temp.backgroundColor = UIColor.whiteColor()
        temp.delegate = self
        temp.scrollEnabled = true //是否可以拖动
        temp.editable = true //编辑
        return temp
    }()
    
    lazy var atButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "compose_mentionbutton_background"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        //temp.backgroundColor = UIColor.brownColor()
        return temp
    }()
    
    lazy var topicButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "compose_trendbutton_background"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        //temp.backgroundColor = UIColor.brownColor()
        return temp
    }()
    
    lazy var locationButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "compose_locatebutton_ready"), forState: .Normal)
        temp.titleLabel?.font = UIFont(fontSize: 14)
        temp.setTitle("成都驷马桥圣地亚家居", forState: .Normal)
        temp.setTitleColor(UIColor.grayColor(), forState: .Normal)
        //temp.backgroundColor = UIColor.brownColor()
        return temp
    }()
    
    lazy var sinaButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "mine_normal"), forState: .Normal)
        
        return temp
    }()
    
    lazy var wechatButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "mine_normal"), forState: .Normal)
        return temp
    }()
    
    lazy var qzoneButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "mine_normal"), forState: .Normal)
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(viewType: ComposeViewType) {
        
        switch viewType {
            case .Header:
                initHeaderView()
            case .Footer:
                initFooterView()
        }
    }
    
    func initHeaderView() {
        
        //self.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 0.3)
        
        self.addSubview(textView)
        self.addSubview(atButton)
        self.addSubview(topicButton)
        self.addSubview(locationButton)
        
        weak var weakSelf: ComposeReusableView? = self
        textView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        atButton.snp_makeConstraints { (make) in
            make.top.equalTo(textView.snp_bottom).offset(0)
            make.left.bottom.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 5, 0, 0))
        }
        topicButton.snp_makeConstraints { (make) in
            make.top.equalTo(textView.snp_bottom).offset(0)
            make.left.equalTo(atButton.snp_right).offset(5)
            make.bottom.equalTo(weakSelf!.snp_bottom).offset(0)
        }
        locationButton.snp_makeConstraints { (make) in
            make.top.equalTo(textView.snp_bottom).offset(0)
            make.left.equalTo(topicButton.snp_right).offset(5)
            make.bottom.equalTo(weakSelf!.snp_bottom).offset(0)
        }
    }
    
    func initFooterView() {
        self.addSubview(sinaButton)
        self.addSubview(wechatButton)
        self.addSubview(qzoneButton)
        
        weak var weakSelf: ComposeReusableView? = self
        sinaButton.snp_makeConstraints { (make) in
            make.top.left.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 10, 0, 0))
        }
        wechatButton.snp_makeConstraints { (make) in
            make.top.equalTo(weakSelf!).offset(0)
            make.left.equalTo(sinaButton.snp_right).offset(5)
        }
        qzoneButton.snp_makeConstraints { (make) in
            make.top.equalTo(weakSelf!).offset(0)
            make.left.equalTo(wechatButton.snp_right).offset(5)
        }
    }
}
