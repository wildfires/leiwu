//
//  MineViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/7/22.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class MineViewCell: UICollectionViewCell {
    
    lazy var coverView: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        contentView.addSubview(coverView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
