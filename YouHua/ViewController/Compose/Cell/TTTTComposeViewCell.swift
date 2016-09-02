//
//  ComposeViewCell.swift
//  YouHua
//
//  Created by 高洋 on 16/7/9.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

protocol ComposeViewCellDelegate: NSObjectProtocol {
    
    func ComposeAddPicture()
}

class ComposeViewCell: UITableViewCell, UITextViewDelegate {
    
    weak var delegate: ComposeViewCellDelegate!
    
    var picRow: Int = 3 //行
    var picCol: Int = 3 //列
    var picMargin: CGFloat = 5 //间距
    var picCount: Int = 9
    
    var pictureArray: Array<String>? {
        
        didSet {
            print("选择了\(pictureArray!.count)张图片")
            
            for view in self.photoView.subviews {
                view.removeFromSuperview()
            }
            //initPhotoView()
        }
    }
    
    lazy var containerView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.whiteColor()
        return temp
    }()
    
    lazy var textView: UITextView = {
        let temp = UITextView()
        temp.font = UIFont(name: FONT_NAME, size: 14)
        temp.backgroundColor = UIColor.whiteColor()
        temp.delegate = self
        temp.scrollEnabled = true //是否可以拖动
        temp.editable = true //编辑
        return temp
    }()
    
    lazy var atButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "compose_mentionbutton_background"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        //temp.backgroundColor = UIColor.brownColor()
        return temp
    }()
    
    lazy var topicButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "compose_trendbutton_background"), forState: .Normal)
        temp.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        //temp.backgroundColor = UIColor.brownColor()
        return temp
    }()
    
    lazy var locationButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "compose_locatebutton_ready"), forState: .Normal)
        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 14)
        temp.setTitle("成都驷马桥圣地亚家居", forState: .Normal)
        temp.setTitleColor(UIColor.grayColor(), forState: .Normal)
        //temp.backgroundColor = UIColor.brownColor()
        return temp
    }()
    
    lazy var photoView: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = UIColor.whiteColor()
        return temp
    }()
    
    lazy var shareLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: FONT_NAME, size: 14)
        temp.text = "分享至："
        temp.textColor = UIColor.grayColor()
        return temp
    }()
    
    lazy var sinaButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "mine_normal"), forState: .Normal)
        
        return temp
    }()
    
    lazy var wechatButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "mine_normal"), forState: .Normal)
        return temp
    }()
    
    lazy var qzoneButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "mine_normal"), forState: .Normal)
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
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.contentView.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        self.selectionStyle = .None //取消cell点击效果
        self.containerView.userInteractionEnabled = true //打开交互
        self.contentView.addSubview(containerView)
        
        weak var weakSelf: ComposeViewCell? = self
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(weakSelf!.contentView).inset(UIEdgeInsetsMake(0, 0, 8, 0))//此处有bug
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initTextView() {
        
        containerView.addSubview(textView)
        containerView.addSubview(atButton)
        containerView.addSubview(topicButton)
        containerView.addSubview(locationButton)
        
        textView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(containerView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        atButton.snp_makeConstraints { (make) in
            make.top.equalTo(textView.snp_bottom).offset(0)
            make.left.bottom.equalTo(containerView).inset(UIEdgeInsetsMake(0, 5, 8, 0))
        }
        topicButton.snp_makeConstraints { (make) in
            make.top.equalTo(textView.snp_bottom).offset(0)
            make.left.equalTo(atButton.snp_right).offset(5)
            make.bottom.equalTo(containerView.snp_bottom).offset(-8)
        }
        locationButton.snp_makeConstraints { (make) in
            make.top.equalTo(textView.snp_bottom).offset(0)
            make.left.equalTo(topicButton.snp_right).offset(5)
            make.bottom.equalTo(containerView.snp_bottom).offset(-8)
        }
    }
    
    func initPhotoView() {
        
        containerView.addSubview(photoView)
        containerView.addSubview(shareLabel)
        containerView.addSubview(sinaButton)
        containerView.addSubview(wechatButton)
        containerView.addSubview(qzoneButton)
        
        let picWidth: CGFloat = (self.frame.size.width - 20 - 2 * picMargin) / CGFloat(picCol)
        let picSize: CGSize = CGSize(width: picWidth, height: picWidth)
        
        if let count = pictureArray?.count {
            
            for index in 0..<count + 1 {
                
                let currentCol: Int = index % picCol //当前列
                let currentRow: Int = index / picRow //当前行
                
                let picX: CGFloat = CGFloat(currentCol) * (picMargin + picSize.width) + 10
                let picY: CGFloat = CGFloat(currentRow) * (picMargin + picSize.height) + 10
                
                let picView: UIImageView = UIImageView(frame: CGRect(x: picX, y: picY, width: picSize.width, height: picSize.height))
                picView.contentMode = .ScaleAspectFill
                picView.clipsToBounds = true
                self.addSubview(picView)
                
                if index == count {
                    
                    picView.tag = index + 200
                    picView.userInteractionEnabled = true
                    let singleTap = UITapGestureRecognizer(target: self, action: #selector(clickAddPicture))
                    picView.addGestureRecognizer(singleTap)
                    
                    picView.image = UIImage(named: "compose_pic_add")
                } else {
                    
                    picView.tag = index + 200
                    picView.userInteractionEnabled = true
                    let singleTap = UITapGestureRecognizer(target: self, action: #selector(clickPicture(_:)))
                    picView.addGestureRecognizer(singleTap)
                    
                    picView.image = UIImage(named: "img_0\(index + 1)")
                }
            }
        } else {
            
            let picView: UIImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: picSize.width, height: picSize.height))
            picView.contentMode = .ScaleAspectFill
            picView.clipsToBounds = true
            self.addSubview(picView)
                
            picView.tag = 200
            picView.userInteractionEnabled = true
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(clickAddPicture))
            picView.addGestureRecognizer(singleTap)
            
            picView.image = UIImage(named: "compose_pic_add")
            
        }
        
        photoView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(containerView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        shareLabel.snp_makeConstraints { (make) in
            make.top.equalTo(photoView.snp_bottom).offset(0)
            make.left.bottom.equalTo(containerView).inset(UIEdgeInsetsMake(0, 5, 8, 0))
        }
        sinaButton.snp_makeConstraints { (make) in
            make.top.equalTo(photoView.snp_bottom).offset(0)
            make.left.equalTo(shareLabel.snp_right).offset(5)
            make.bottom.equalTo(containerView.snp_bottom).offset(-8)
        }
        wechatButton.snp_makeConstraints { (make) in
            make.top.equalTo(photoView.snp_bottom).offset(0)
            make.left.equalTo(sinaButton.snp_right).offset(5)
            make.bottom.equalTo(containerView.snp_bottom).offset(-8)
        }
        qzoneButton.snp_makeConstraints { (make) in
            make.top.equalTo(photoView.snp_bottom).offset(0)
            make.left.equalTo(wechatButton.snp_right).offset(5)
            make.bottom.equalTo(containerView.snp_bottom).offset(-8)
        }
    }
    
    //点击图片
    func clickPicture(gestureRecognizer: UIGestureRecognizer) {
        
        print("点击了图片")
//        let view: UIImageView = gestureRecognizer.view as! UIImageView
//        
//        if delegate != nil {
//            delegate.pictureView(self, didSelectedPictureAtIndex: view.tag)
//        }
    }
    
    //点击添加
    func clickAddPicture() {
        
        if delegate != nil {
            delegate.ComposeAddPicture()
        }
    }
    
}
