//
//  BasicViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/7/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class BasicViewCell: UITableViewCell {

    lazy var txt: UILabel = {
        let temp = UILabel()
        temp.numberOfLines = 0
        temp.font = UIFont(name: FONT_NAME, size: 14)
        return temp
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.contentView.addSubview(txt)
        
        txt.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView).inset(UIEdgeInsetsMake(0, 8, 0, 0))
        }
    }
    
    func rowHeight(body: String) -> CGFloat {
        
        let textHight: CGFloat = body.getSpaceLabelHeightWithSpeace(4, font: UIFont(name: FONT_NAME, size: 14)!, width: SCREEN_WIDTH - 16)
        return textHight
    }

}
