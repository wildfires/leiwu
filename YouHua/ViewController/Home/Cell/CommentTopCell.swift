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
    
    lazy var homeViewCellContent: HomeViewCellContent = {
        let temp = HomeViewCellContent()
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
        self.containerView.addSubview(homeViewCellContent)
        
        weak var weakSelf: CommentTopCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, Margin_Height, 0))
        }
        
        homeViewCellContent.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.containerView).inset(UIEdgeInsetsMake(Margin_Height, 0, Margin_Height, 0))
        }
    }
    
    func rowHeight(body: String) -> CGFloat {
        
        //图片高度 文字高度
        let textHight: CGFloat = body.getSpaceLabelHeightWithSpeace(6, font: UIFont(fontSize: 14), width: Screen_Width - (2 * Margin_Width))
        //Margin_Height + 内容？+ Margin_Height + 图片180 + Margin_Height + Margin_Height
        return 180 + textHight + 4 * Margin_Height
    }
    
    func configureCell(model: HomeModel, indexPath: NSIndexPath) {
        
        if model.type == "video" {
            homeViewCellContent.videoPlayView.hidden = false
            homeViewCellContent.videoPlayView.tag = indexPath.row
            homeViewCellContent.numberLabel.text = "00:10"
        } else {
            homeViewCellContent.videoPlayView.hidden = true
            homeViewCellContent.numberLabel.text = "\(model.photo) 张图"
        }
        
        if let url: String = model.cover {
            homeViewCellContent.coverView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Picture))
        }
        homeViewCellContent.digestLabel.attributedText = model.content!.stringWithParagraphlineSpeace(6, color: Color_Tags, font: UIFont(fontSize: 14))
    }
}
