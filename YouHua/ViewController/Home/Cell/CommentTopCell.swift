//
//  CommentTopCell.swift
//  YouHua
//
//  Created by 高洋 on 16/8/21.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CommentTopCell: UITableViewCell, WFRichText {

    lazy var containerView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.whiteColor()
        return temp
    }()
    
    lazy var homeCellContView: HomeCellContView = {
        let temp = HomeCellContView()
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
        
        //取消cell点击效果
        self.selectionStyle = .None
        //打开交互
        self.containerView.userInteractionEnabled = true
        
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(homeCellContView)
        
        weak var weakSelf: CommentTopCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 16, 0))
        }
        
        homeCellContView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(0, 0, 12, 0))
        }
    }
    
    func rowHeight(body: String) -> CGFloat {
        
        //图片高度 文字高度
        let textHight: CGFloat = body.getSpaceLabelHeightWithSpeace(6, font: UIFont(fontSize: 14), width: Screen_Width - 16) // 50 + 16//body.sizeWithFont(UIFont(name: FONT_NAME, size: 16)!, maxSize: 16).height
        //print(pictureHight) 头像36 图片200 评论26 内容？
        return 282 + textHight
    }
    
    func configureCell(model: HomeModel, indexPath: NSIndexPath) {
        
        if model.type == "video" {
            homeCellContView.playButton.hidden = false
            homeCellContView.playButton.tag = indexPath.row
            homeCellContView.numberLabel.text = "00:10"
        } else {
            homeCellContView.playButton.hidden = true
            homeCellContView.numberLabel.text = "\(model.photo) 张图"
        }
        
        if let url: String = model.cover {
            homeCellContView.coverView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Picture))
        }
//        homeCellContView.barView.praiseButton.setTitle(model.likes!.withCount, forState: .Normal)
//        homeCellView.barView.discussButton.setTitle(model.comments!.withCount, forState: .Normal)
        homeCellContView.digestLabel.attributedText = model.content!.stringWithParagraphlineSpeace(6, color: Color_Tags, font: UIFont(fontSize: 14))
    }
}
