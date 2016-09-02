//
//  FindViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/6/28.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class FindViewCell: UITableViewCell {

    lazy var coverView: UIImageView = {
        let temp = UIImageView()
        //temp.image = UIImage(named: "img_02")
        //temp.alpha = 0.9
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "视频"
        temp.textColor = UIColor.whiteColor()
        temp.textAlignment = .Center
        temp.font = UIFont(name: FONT_NAME, size: 26)
        //temp.backgroundColor = UIColor.redColor()
        return temp
    }()
    lazy var subTitleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "VIDEO"
        temp.textColor = UIColor.whiteColor()
        temp.textAlignment = .Center
        temp.font = UIFont(name: FONT_NAME, size: 26)
        //temp.backgroundColor = UIColor.orangeColor()
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
        
        self.selectionStyle = .None
        
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        
        weak var weakSelf: FindViewCell? = self
        coverView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(weakSelf!.contentView.center.y).offset(-20)
            make.left.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(40)
        }
        
        subTitleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(weakSelf!.contentView.center.y).offset(15)
            make.left.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            
            make.height.equalTo(30)
        }
    }
}
