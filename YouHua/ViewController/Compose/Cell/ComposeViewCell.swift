//
//  ComposeViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/7/10.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class ComposeViewCell: UICollectionViewCell {
    
    lazy var coverView: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        //temp.image = UIImage(named: "img_02")
        //temp.backgroundColor = UIColor.grayColor()
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    lazy var deleteButton: UIButton = {
        let temp = UIButton(frame: CGRect(x: self.frame.size.width - 20, y: 0, width: 20, height: 20))
        temp.backgroundColor = RGBA(red: 255, green: 0, blue: 0, alpha: 1)
        temp.setImage(UIImage(named: "compose_card_delete_highlighted"), forState: .Normal)
        return temp
    }()
    
    /// 是否隐藏删除按钮
    var isHiddenDelBut = false {
        didSet {
            deleteButton.hidden = isHiddenDelBut
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(deleteButton)
        deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
