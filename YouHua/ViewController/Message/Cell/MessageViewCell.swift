//
//  MessageViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/6/29.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

class MessageViewCell: UITableViewCell {

    let avatarHeight: CGFloat = 44
    
    lazy var avatarView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .ScaleAspectFill
        temp.layer.cornerRadius = self.avatarHeight / 2
        temp.layer.masksToBounds = true
        return temp
    }()
    
    lazy var nickNameLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(fontSize: 14)
        return temp
    }()
    
    lazy var digestLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(fontSize: 12)
        temp.textColor = Color_Gray
        return temp
    }()
    
    lazy var dateLabel: UILabel = {
        let temp = UILabel()
        //temp.textAlignment = .Right
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
        
        self.contentView.addSubview(avatarView)
        self.contentView.addSubview(nickNameLabel)
        self.contentView.addSubview(digestLabel)
        self.contentView.addSubview(dateLabel)
        
        weak var weakSelf: MessageViewCell? = self
        avatarView.snp_makeConstraints { (make) in
            make.top.left.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(8, 8, 0, 0))
            make.width.height.equalTo(weakSelf!.avatarHeight)
        }
        
        nickNameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(weakSelf!.contentView).offset(8)
            make.left.equalTo(avatarView.snp_right).offset(8)
            make.height.equalTo(weakSelf!.avatarHeight / 2)
        }
        
        digestLabel.snp_makeConstraints { (make) in
            make.top.equalTo(nickNameLabel.snp_bottom).offset(0)
            make.left.equalTo(avatarView.snp_right).offset(8)
            make.right.equalTo(weakSelf!.contentView).offset(-8)
            make.height.equalTo(weakSelf!.avatarHeight / 2)
        }
        
        dateLabel.snp_makeConstraints { (make) in
            make.top.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(8, 0, 0, 8))
        }
    }
}
