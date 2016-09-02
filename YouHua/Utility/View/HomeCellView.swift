//
//  HomeCellView.swift
//  YouHua
//
//  Created by 高洋 on 16/8/21.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

protocol HomeCellViewDelegate: NSObjectProtocol {
    func homeCellView(cell: HomeCellView, didSelectedVideoAtIndex row: Int)
}

class HomeCellView: UIView {

    weak var delegate: HomeCellViewDelegate!
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    lazy var coverView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    lazy var videoView: VideoView = {
        let temp = VideoView()
        temp.hidden = true
        return temp
    }()
    
    var playButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "player_play"), forState: .Normal)
        temp.layer.borderColor = RGBA(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
        temp.layer.borderWidth = 1
        temp.layer.cornerRadius = 25
        temp.layer.masksToBounds = true
        //temp.addTarget(self, action: #selector(playVide(_:)), forControlEvents: .TouchUpInside)
        temp.hidden = true
        return temp
    }()//播放按钮
    
    lazy var numberLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: FONT_NAME, size: 12)
        temp.textColor = UIColor.whiteColor()
        temp.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        temp.textAlignment = .Center
        return temp
    }()
    
    lazy var barView: HomeCellBarView = {
        let temp = HomeCellBarView()
        temp.backgroundColor = UIColor.whiteColor()
        return temp
    }()
    
    lazy var digestLabel: UILabel = {
        let temp = UILabel()
        //temp.font = UIFont(name: FONT_NAME, size: 14)
        temp.numberOfLines = 0
        //temp.setLineSpacing
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
        self.addSubview(coverView)
        self.addSubview(videoView)
        self.addSubview(playButton)
        self.addSubview(numberLabel)
        self.addSubview(digestLabel)
        self.addSubview(barView)
        
        weak var weakSelf: HomeCellView? = self
        coverView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(200)
        }
        
        videoView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(200)
        }
        
        playButton.snp_makeConstraints { (make) in
            make.center.equalTo(coverView)
            make.size.equalTo(50)
        }
        
        numberLabel.snp_makeConstraints { (make) in
            make.bottom.right.equalTo(coverView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.size.equalTo(CGSize(width: 45, height: 25))
        }
        
        barView.snp_makeConstraints { (make) in
            make.top.equalTo(coverView.snp_bottom).offset(0)
            make.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 8, 0, 8))
            make.height.equalTo(34)//不设置size会没有点击效果 26 + 8 
        }
        
        digestLabel.snp_makeConstraints { (make) in
            make.top.equalTo(barView.snp_bottom).offset(12)
            make.left.bottom.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 8, 0, 8)) //UIEdgeInsetsMake(0, 8, 12, 8))
        }
        
        playButton.addTarget(self, action: #selector(playVideo(_:)), forControlEvents: .TouchUpInside)
    }
    
    func playVideo(button: UIButton) {
        
        if delegate != nil {
            delegate.homeCellView(self, didSelectedVideoAtIndex: button.tag)
        }
    }
}
