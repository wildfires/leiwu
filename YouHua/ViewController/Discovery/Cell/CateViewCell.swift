//
//  CateViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/6/28.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class CateViewCell: UICollectionViewCell {
    
    lazy var coverView: UIImageView = {
        let temp = UIImageView()
        //temp.image = UIImage(named: "img_02")
        //temp.backgroundColor = UIColor.grayColor()
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        //temp.text = "兰花"
        //temp.textColor = UIColor.whiteColor()
        temp.textAlignment = .Center
        temp.font = UIFont(name: FONT_NAME, size: 12)
        temp.backgroundColor = RGBA(red: 250, green: 250, blue: 250, alpha: 1)
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
        
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(titleLabel)
        
        weak var weakSelf: CateViewCell? = self
        coverView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.bottom.equalTo(titleLabel.snp_top).offset(0)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(30)
        }
    }
}
