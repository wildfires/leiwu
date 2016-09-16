//
//  HomeViewCellContent.swift
//  YouHua
//
//  Created by 高洋 on 16/9/15.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

protocol HomeViewCellContentDelegate: NSObjectProtocol {
    
    func homeViewCellContent(viewType: HomeViewCellContentType, didSelectedAtIndex row: Int)
}

enum HomeViewCellContentType: Int {
    case View
    case Cover
    case Video
}

class HomeViewCellContent: UIView {

    weak var delegate: HomeViewCellContentDelegate!
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    lazy var digestLabel: UILabel = {
        let temp = UILabel()
        //temp.font = UIFont(name: FONT_NAME, size: 14)
        temp.numberOfLines = 0
        //temp.setLineSpacing
        return temp
    }()
    
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
    
    lazy var videoPlayView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "player_play")
        temp.contentMode = .Center
        temp.clipsToBounds = true
        temp.hidden = true
        return temp
    }()//播放遮罩
    
    lazy var numberLabel: WFLabel = {
        let temp = WFLabel()
        temp.font = UIFont(fontSize: 12)
        temp.textColor = Color_White
        temp.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        temp.textAlignment = .Center
        temp.textInsets = UIEdgeInsetsMake(4, 4, 4, 4)
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
        
        self.addSubview(digestLabel)
        self.addSubview(coverView)
        self.addSubview(videoView)
        self.addSubview(videoPlayView)
        self.addSubview(numberLabel)
        
        weak var weakSelf: HomeViewCellContent? = self
        digestLabel.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, Margin_Width, 0, Margin_Width))
        }
        
        coverView.snp_makeConstraints { (make) in
            make.top.equalTo(digestLabel.snp_bottom).offset(Margin_Height)
            make.left.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, Margin_Width, 0, Margin_Width))
            make.height.equalTo(180)
        }
        
        videoView.snp_makeConstraints { (make) in
            make.center.equalTo(coverView)
            make.size.equalTo(coverView.snp_size)
        }
        
        videoPlayView.snp_makeConstraints { (make) in
            make.center.equalTo(coverView)
            make.size.equalTo(coverView.snp_size)
        }
        
        numberLabel.snp_makeConstraints { (make) in
            make.bottom.right.equalTo(coverView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            //make.size.equalTo(CGSize(width: 45, height: 25))
            //make.height.equalTo(25)
        }
        
        self.userInteractionEnabled = true
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewAction(_:)))
        self.addGestureRecognizer(viewTap)
        
        coverView.userInteractionEnabled = true
        let coverTap = UITapGestureRecognizer(target: self, action: #selector(coverAction(_:)))
        coverView.addGestureRecognizer(coverTap)
        
        videoPlayView.userInteractionEnabled = true
        let videoPlayTap = UITapGestureRecognizer(target: self, action: #selector(videoAction(_:)))
        videoPlayView.addGestureRecognizer(videoPlayTap)
    }
    
    func viewAction(gestRecognizer: UITapGestureRecognizer) {
        
        guard let view = gestRecognizer.view where delegate != nil else {
            return
        }
        delegate.homeViewCellContent(.View, didSelectedAtIndex: view.tag)
    }
    
    func coverAction(gestRecognizer: UITapGestureRecognizer) {
        
        guard let view = gestRecognizer.view where delegate != nil else {
            return
        }
        delegate.homeViewCellContent(.Cover, didSelectedAtIndex: view.tag)
    }
    
    func videoAction(gestRecognizer: UITapGestureRecognizer) {
        
        guard let view = gestRecognizer.view where delegate != nil else {
            return
        }
        delegate.homeViewCellContent(.Video, didSelectedAtIndex: view.tag)
    }

}
