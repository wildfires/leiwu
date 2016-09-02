//
//  PictureView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/1.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

protocol PictureViewDelegate: NSObjectProtocol {
    func pictureView(pictureView: PictureView, didSelectedPictureAtIndex index: Int)
}

class PictureView: UIView {

    weak var delegate: PictureViewDelegate!
    
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    var picRow: Int = 3 //行
    var picCol: Int = 3 //列
    var picMargin: CGFloat = 5 //间距
    
    var picCount: Int = 5
    
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
        
        let picSize: CGSize = pictureWithSize(picCount)
        
        for index in 0..<picCount {
            
            let currentCol: Int = index % picCol //当前列
            let currentRow: Int = index / picRow //当前行
            let picX: CGFloat = CGFloat(currentCol) * (picMargin + picSize.width)
            let picY: CGFloat = CGFloat(currentRow) * (picMargin + picSize.height)
            
            let picView: UIImageView = UIImageView(frame: CGRect(x: picX, y: picY, width: picSize.width, height: picSize.height))
            picView.contentMode = .ScaleAspectFill
            picView.clipsToBounds = true
            self.addSubview(picView)
            
            picView.tag = index + 200
            
            picView.userInteractionEnabled = true
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(clickPicture(_:)))
            picView.addGestureRecognizer(singleTap)
            
            picView.image = UIImage(named: "img_0\(index + 1)")
        }
    }
    
    func pictureWithSize(count: Int) -> CGSize {
        
        switch count {
        case 0:
            return CGSizeZero
        case 1:
            return CGSize(width: VIEW_WIDTH, height: VIEW_WIDTH / 2)
        case 2:
            let picWidth: CGFloat = (VIEW_WIDTH - picMargin) / 2
            return CGSize(width: picWidth, height: picWidth)
        default:
            let picWidth: CGFloat = (VIEW_WIDTH - 2 * picMargin) / 3
            return CGSize(width: picWidth, height: picWidth)
        }
    }
    
    func pictureViewSize(count: Int) -> CGFloat {
        
        let picHeight: CGFloat = pictureWithSize(count).height
        
        switch count {
        case 0:
            return 0
        case 1, 2, 3:
            return picHeight
        case 4, 5, 6:
            return 2 * picHeight + picMargin
        default:
            return 3 * picHeight + 2 * picMargin
        }
    }
    
    //点击图片
    func clickPicture(gestureRecognizer: UIGestureRecognizer) {
        
        let view: UIImageView = gestureRecognizer.view as! UIImageView
        
        if delegate != nil {
            delegate.pictureView(self, didSelectedPictureAtIndex: view.tag)
        }
    }
}
