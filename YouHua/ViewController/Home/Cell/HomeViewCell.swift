//
//  HomeViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class HomeViewCell: UITableViewCell, WFRichText {
    
    var rowHeight: CGFloat = 0
    
    lazy var containerView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.whiteColor()
        return temp
    }()

    lazy var avatarView: AvatarView = {
        let temp = AvatarView()
        temp.initView(AvatarSize.Large, boxSize: 36) //设置头像大小
        return temp
    }()
    
    lazy var homeCellContView: HomeCellContView = {
        let temp = HomeCellContView()
        return temp
    }()
    
    lazy var homeCellBarView: HomeCellBarView = {
        let temp = HomeCellBarView()
        //temp.backgroundColor = UIColor.grayColor()
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
        
        self.contentView.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(avatarView)
        self.containerView.addSubview(homeCellContView)
        self.containerView.addSubview(homeCellBarView)
        //取消cell点击效果
        self.selectionStyle = .None
        //打开交互
        self.containerView.userInteractionEnabled = true
        
        weak var weakSelf: HomeViewCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, Margin_Height, 0))
        }
        
        avatarView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(Margin_Height / 2, Margin_Width, 0, Margin_Width))
            make.height.equalTo(36 + Margin_Height / 2) //头像高度 36 头像内底部间距 MARGIN
        }
        
        homeCellContView.snp_makeConstraints { (make) in
            make.top.equalTo(avatarView.snp_bottom).offset(Margin_Height)
            make.left.right.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        homeCellBarView.snp_makeConstraints { (make) in
            make.top.equalTo(homeCellContView.snp_bottom).offset(Margin_Height)
            make.left.bottom.right.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(0, Margin_Width, 0, Margin_Width))
            make.height.equalTo(30) //不设置size会没有点击效果 26 + MARGIN
        }
    }
    
    func rowHeight(body: String) -> CGFloat {
        
        //图片高度 文字高度
        let textHight: CGFloat = body.getSpaceLabelHeightWithSpeace(6, font: UIFont(fontSize: 14), width: Screen_Width - 2 * Margin_Width)
        //Margin_Height/2 + 头像36 + Margin_Height/2 + 内容？+ Margin_Height + 图片200 + Margin_Height + 工具栏30 + Margin_Height + Margin_Height
        return 266 + textHight + 5 * Margin_Height
    }
    
    func configureCell(model: HomeModel, indexPath: NSIndexPath) {
        
        let row: Int = indexPath.row
        
        self.rowHeight = self.rowHeight(model.content!)
        
        if model.type == "video" {
            homeCellContView.playButton.hidden = false
            homeCellContView.playButton.tag = row
            homeCellContView.numberLabel.text = "00:10"
        } else {
            homeCellContView.playButton.hidden = true
            homeCellContView.numberLabel.text = "\(model.photo!) 张图"
        }
        if let url: String = model.avatar {
            avatarView.headView.sd_setImageWithURL(NSURL(string: url))
        }
        if let url: String = model.cover {
            homeCellContView.coverView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Picture))
        }
        avatarView.nickLabel.text = "三杯茶茶"//model.nickname!
        avatarView.shortLabel.text = "耒物工作室创始人"//model.dateline!.withDate
        
        homeCellContView.digestLabel.attributedText = model.content!.stringWithParagraphlineSpeace(6, color: Color_Tags, font: UIFont(fontSize: 14))
        
        homeCellBarView.praiseButton.setTitle(model.likes!.withCount, forState: .Normal)
        homeCellBarView.discussButton.setTitle(model.comments!.withCount, forState: .Normal)
        homeCellBarView.dateButton.setTitle("5分钟前", forState: .Normal)
        //homeCellView.barView.dateLabel.text = "5分钟前"
        //homeCellView.barView.backgroundColor = UIColor.grayColor()
        
        avatarView.headView.tag = row
        avatarView.nickLabel.tag = row
        homeCellBarView.rowId = row
        homeCellBarView.praiseButton.tag = row + 1
        homeCellBarView.discussButton.tag = row + 2
        homeCellBarView.shareButton.tag = row + 3
    }
}