//
//  MallViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/9/16.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class MallViewCell: UICollectionViewCell {
    
    lazy var coverView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    lazy var titleLabel: WFLabel = {
        let temp = WFLabel()
        temp.font = UIFont(fontSize: 14)
        temp.textColor = Color_Black
        temp.textAlignment = .Center
        return temp
    }()
    
    lazy var priceLabel: WFLabel = {
        let temp = WFLabel()
        temp.font = UIFont(fontSize: 12)
        temp.textColor = Color_Red
        temp.textAlignment = .Center
        return temp
    }()
    
    lazy var moreButton: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = Color_ButtonMore
        temp.setTitle("READ MORE", forState: .Normal)
        temp.setTitleColor(Color_White, forState: .Normal)
        temp.titleLabel?.font = UIFont(fontSize: 12)
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        contentView.backgroundColor = Color_White
        contentView.addSubview(coverView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(moreButton)
        
        //weak var weakSelf: MallViewCell? = self
        coverView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(contentView).offset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo((Screen_Width - 3 * Margin_Width) / 2)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(coverView.snp_bottom).offset(10)
            make.left.right.equalTo(contentView).inset(UIEdgeInsetsMake(0, Margin_Width, 0, Margin_Width))
            make.height.equalTo(20)
        }
        
        priceLabel.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(4)
            make.left.right.equalTo(contentView).inset(UIEdgeInsetsMake(0, Margin_Width, 0, Margin_Width))
            make.height.equalTo(20)
        }
        
        moreButton.snp_makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp_bottom).offset(8)
            make.left.right.equalTo(contentView).inset(UIEdgeInsetsMake(0, Margin_Width, 0, Margin_Width))
            make.height.equalTo(28)
        }
    }
}