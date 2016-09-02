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
        temp.font = UIFont(name: FONT_NAME, size: 13)
        temp.textColor = RGBA(red: 22, green: 164, blue: 174, alpha: 1)
        return temp
    }()
    
    lazy var dateLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: FONT_NAME, size: 11)
        temp.textColor = UIColor.grayColor()
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
        self.addSubview(dateLabel)
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
                make.left.equalTo(headView.snp_right).offset(8)
                make.height.equalTo(boxSize / 2)
            }
            dateLabel.snp_makeConstraints { (make) in
                make.left.equalTo(headView.snp_right).offset(8)
                make.bottom.equalTo(headView.snp_bottom).offset(0)
                make.height.equalTo(boxSize / 2)
            }
        case .Small:
            
            nickLabel.snp_makeConstraints { (make) in
                make.top.equalTo(weakSelf!).offset(0)
                make.left.equalTo(headView.snp_right).offset(8)
                make.height.equalTo(boxSize)
            }
            dateLabel.snp_makeConstraints { (make) in
                make.top.equalTo(weakSelf!).offset(3)
                make.left.equalTo(nickLabel.snp_right).offset(4)
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
}
