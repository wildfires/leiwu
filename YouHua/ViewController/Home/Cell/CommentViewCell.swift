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
        return temp
    }()
    
    lazy var praiseButton: UIButton = {
        let temp = UIButton(type: UIButtonType.Custom)
        temp.setImage(UIImage(named: "timeline_icon_unlike"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        temp.titleLabel?.font = UIFont(fontSize: 12)
        temp.setTitle("赞", forState: .Normal)
        temp.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        temp.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        return temp
    }()//赞美
    
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
        
        avatarView.initView(AvatarSize.Small, boxSize: 26)
        
        self.contentView.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        
        //取消cell点击效果
        self.selectionStyle = .None
        //打开交互
        self.containerView.userInteractionEnabled = true
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(avatarView)
        self.containerView.addSubview(praiseButton)
        self.containerView.addSubview(digestLabel)
        
        weak var weakSelf: CommentViewCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 1, 0))
        }
        
        avatarView.snp_makeConstraints { (make) in
            make.top.left.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(8, 8, 0, 0))
            make.right.equalTo(praiseButton.snp_left).offset(-8)
            make.height.equalTo(26)
        }
        
        praiseButton.snp_makeConstraints { (make) in
            make.top.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(8, 0, 0, 8))
        }
        
        digestLabel.snp_makeConstraints { (make) in
            make.top.equalTo(avatarView.snp_bottom).offset(8)
            make.left.bottom.right.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(0, 42, 8, 8))
        }
    }
    
    func rowHeight(body: String) -> CGFloat {
        
        //图片高度 文字高度
        let textHight: CGFloat = body.getSpaceLabelHeightWithSpeace(6, font: UIFont(fontSize: 14), width: Screen_Width - 44) // 50 + 16//body.sizeWithFont(UIFont(fontSize: 16)!, maxSize: 16).height
        //print(pictureHight) 头像36 图片200 评论26 内容？
        return 32 + 26 + textHight
    }
    
    func configureCell(model: HomeModel, indexPath: NSIndexPath) {
        
        avatarView.headView.tag = indexPath.row
        avatarView.nickLabel.tag = indexPath.row
        if let url: String = model.avatar {
            avatarView.headView.sd_setImageWithURL(NSURL(string: url))
        }
        avatarView.nickLabel.text = model.nickname
        avatarView.shortLabel.text = model.dateline!.withDate
        digestLabel.attributedText = model.content!.stringWithParagraphlineSpeace(6, color: Color_Black, font: UIFont(fontSize: 14))
    }
}
