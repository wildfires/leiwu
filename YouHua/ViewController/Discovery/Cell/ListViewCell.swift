//
//  ListViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/7/7.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class ListViewCell: UITableViewCell {

    lazy var containerView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = Color_White
        return temp
    }()
    
    lazy var coverView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(fontSize: 14)
        return temp
    }()
    
    lazy var subTitleLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(fontSize: 12)
        temp.textColor = Color_Gray
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
        //移除视图
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.contentView.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        self.selectionStyle = .None
        
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(coverView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(subTitleLabel)
        
        weak var weakSelf: ListViewCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 8, 0))
        }
        
        coverView.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(containerView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.width.equalTo(2 * self.frame.size.width / 5)
        }
        titleLabel.snp_makeConstraints { (make) in
            make.top.right.equalTo(containerView).inset(UIEdgeInsetsMake(5, 0, 0, 0))
            make.left.equalTo(coverView.snp_right).offset(8)
            make.height.equalTo(26)
        }
        subTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.left.equalTo(coverView.snp_right).offset(8)
            make.right.equalTo(containerView.snp_right).offset(0)
            make.height.equalTo(14)
        }
    }
    
    
}
