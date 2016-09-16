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
        temp.backgroundColor = Color_White
        return temp
    }()

    lazy var homeViewCellAvatar: HomeViewCellAvatar = {
        let temp = HomeViewCellAvatar()
        temp.initView(HomeViewCellAvatarSize.Large, boxSize: 36) //设置头像大小
        temp.backgroundColor = Color_White
        return temp
    }()
    
    lazy var homeViewCellContent: HomeViewCellContent = {
        let temp = HomeViewCellContent()
        return temp
    }()
    
    lazy var homeViewCellBar: HomeViewCellBar = {
        let temp = HomeViewCellBar()
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
        
        self.contentView.backgroundColor = Color_Background
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(homeViewCellAvatar)
        self.containerView.addSubview(homeViewCellContent)
        self.containerView.addSubview(homeViewCellBar)
        //取消cell点击效果
        self.selectionStyle = .None
        //打开交互
        self.containerView.userInteractionEnabled = true
        
        weak var weakSelf: HomeViewCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, Margin_Height, 0))
        }
        
        homeViewCellAvatar.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(Margin_Height / 2, Margin_Width, 0, Margin_Width))
            make.height.equalTo(36 + Margin_Height / 2) //头像高度 36 头像内底部间距 Margin_Height/2
        }
        
        homeViewCellContent.snp_makeConstraints { (make) in
            make.top.equalTo(homeViewCellAvatar.snp_bottom).offset(Margin_Height)
            make.left.right.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        homeViewCellBar.snp_makeConstraints { (make) in
            make.top.equalTo(homeViewCellContent.snp_bottom).offset(Margin_Height)
            make.left.bottom.right.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(0, Margin_Width, 0, Margin_Width))
            make.height.equalTo(26) //不设置size会没有点击效果 26
        }
    }
    
    func rowHeight(body: String) -> CGFloat {
        
        //图片高度 文字高度
        let textHight: CGFloat = body.getSpaceLabelHeightWithSpeace(6, font: UIFont(fontSize: 14), width: Screen_Width - (2 * Margin_Width))
        //Margin_Height/2 + 头像36 + Margin_Height/2 + 内容？+ Margin_Height + 图片180 + Margin_Height + 工具栏26 + Margin_Height + Margin_Height
        return 242 + textHight + 5 * Margin_Height
    }
    
    func configureCell(model: HomeModel, indexPath: NSIndexPath) {
        
        let row: Int = indexPath.row
        
        self.rowHeight = self.rowHeight(model.content!)
        
        if model.type == "video" {
            homeViewCellContent.videoPlayView.hidden = false
            homeViewCellContent.videoPlayView.tag = row
            homeViewCellContent.numberLabel.text = "01:00:10"
        } else {
            homeViewCellContent.videoPlayView.hidden = true
            homeViewCellContent.numberLabel.text = "\(model.photo!) 张图"
        }
        
        if let url: String = model.avatar {
            homeViewCellAvatar.headView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Avatar))
        }
        
        if let url: String = model.cover {
            homeViewCellContent.coverView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Picture))
        }
        
        homeViewCellAvatar.nickLabel.text = "三杯茶茶"//model.nickname!
        homeViewCellAvatar.shortLabel.text = "耒物工作室创始人"
        
        homeViewCellContent.digestLabel.attributedText = model.content!.stringWithParagraphlineSpeace(6, color: Color_Description, font: UIFont(fontSize: 14))
        
        homeViewCellBar.praiseButton.setTitle(model.likes!.withCount, forState: .Normal)
        homeViewCellBar.discussButton.setTitle(model.comments!.withCount, forState: .Normal)
        homeViewCellBar.dateLabel.text = model.dateline!.withDate
        
        homeViewCellContent.tag = row
        homeViewCellContent.coverView.tag = row
        
        homeViewCellAvatar.headView.tag = row
        homeViewCellAvatar.nickLabel.tag = row
        homeViewCellBar.rowID = row
        homeViewCellBar.praiseButton.tag = row + 1
        homeViewCellBar.discussButton.tag = row + 2
        homeViewCellBar.shareButton.tag = row + 3
    }
}