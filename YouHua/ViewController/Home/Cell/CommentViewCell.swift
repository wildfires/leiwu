//
//  CommentViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/8/20.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class CommentViewCell: UITableViewCell {

    lazy var containerView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.whiteColor()
        return temp
    }()
    
    lazy var avatarView: AvatarView = {
        let temp = AvatarView()
        temp.initView(AvatarSize.Small, boxSize: 26)
        return temp
    }()
    
    lazy var digestLabel: UILabel = {
        let temp = UILabel()
        //temp.font = UIFont(fontSize: 14)
        temp.numberOfLines = 0
        //temp.setLineSpacing
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
        
        self.contentView.backgroundColor = Color_Background
        
        //取消cell点击效果
        self.selectionStyle = .None
        //打开交互
        self.containerView.userInteractionEnabled = true
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(avatarView)
        self.containerView.addSubview(digestLabel)
        
        weak var weakSelf: CommentViewCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 1, 0))
        }
        
        avatarView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(Margin_Width, Margin_Width, 0, Margin_Width))
            make.height.equalTo(26)
        }
        
        digestLabel.snp_makeConstraints { (make) in
            make.top.equalTo(avatarView.snp_bottom).offset(4)
            make.left.bottom.right.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(0, 2 * Margin_Width + 26, Margin_Width, Margin_Width))
        }
    }
    
    func rowHeight(body: String) -> CGFloat {
        
        //图片高度 文字高度
        let textHight: CGFloat = body.getSpaceLabelHeightWithSpeace(4, font: UIFont(fontSize: 14), width: Screen_Width - (3 * Margin_Width + 26))
        //Margin_Width + 头像26 + 4 + 内容？+ Margin_Width + 1
        return 31 + textHight + 2 * Margin_Width
    }
    
    func configureCell(model: HomeModel, indexPath: NSIndexPath) {
        
        avatarView.headView.tag = indexPath.row
        avatarView.nickLabel.tag = indexPath.row
        if let url: String = model.avatar {
            avatarView.headView.sd_setImageWithURL(NSURL(string: url))
        }
        avatarView.nickLabel.text = model.nickname
        avatarView.shortLabel.text = model.dateline!.withDate
        digestLabel.attributedText = model.content!.stringWithParagraphlineSpeace(4, color: Color_Description, font: UIFont(fontSize: 14))
    }
}
