//
//  BannerView.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SDWebImage

protocol BannerViewDelegate: NSObjectProtocol {
    func bannerView(bannerView: BannerView, didSelectedBannerAtIndex index: Int)
}

class BannerView: UIView, UIScrollViewDelegate {

    weak var delegate: BannerViewDelegate!
    var imageArray: Array<String>? {
        
        didSet {
            initView()
        }
    }
    
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: NSTimer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: VIEW_WIDTH, height: VIEW_HEIGHT))
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false //取消弹簧效果
        
        //设置分页
        pageControl = UIPageControl(frame: CGRect(x: 0, y: VIEW_HEIGHT - 30, width: VIEW_WIDTH, height: 30))
        pageControl.currentPage = 0
        pageControl.userInteractionEnabled = false //关闭交互
        pageControl.currentPageIndicatorTintColor = Color_Red
        pageControl.pageIndicatorTintColor = Color_Gray
        
        self.addSubview(scrollView)
        self.addSubview(pageControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        //移除视图
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        
        //SDImageCache.sharedImageCache().clearDisk()
        //SDImageCache.sharedImageCache().clearMemory()
        
        if let count = imageArray?.count {
            //设置总页数
            pageControl?.numberOfPages = count
            
            for index in 0..<count {
                let imageView: UIImageView = UIImageView(frame: CGRect(x: VIEW_WIDTH * CGFloat(index), y: 0, width: VIEW_WIDTH, height: VIEW_HEIGHT))
                //图片填充方式
                imageView.contentMode = .ScaleAspectFill
                imageView.clipsToBounds = true
                scrollView.addSubview(imageView)
                
                imageView.tag = index + 100
                //打开交互
                imageView.userInteractionEnabled = true
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(clickBanner(_:)))
                imageView.addGestureRecognizer(singleTap)
                
                if let url: String = imageArray![index] {
                    //imageView.kf_setImageWithURL(NSURL(string: url)!)
                    imageView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Picture))
                }
            }
            
            //前后加图
            let imageLeft: UIImageView = UIImageView(frame: CGRect(x: -VIEW_WIDTH, y: 0, width: VIEW_WIDTH, height: VIEW_HEIGHT))
            imageLeft.contentMode = .ScaleAspectFill
            imageLeft.clipsToBounds = true
            scrollView.addSubview(imageLeft)
            if let url: String = imageArray![count - 1] {
                //imageLeft.kf_setImageWithURL(NSURL(string: url)!)
                imageLeft.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Picture))
            }
            
            let imageRight: UIImageView = UIImageView(frame: CGRect(x: VIEW_WIDTH * CGFloat(count), y: 0, width: VIEW_WIDTH, height: VIEW_HEIGHT))
            imageRight.contentMode = .ScaleAspectFill
            imageRight.clipsToBounds = true
            scrollView.addSubview(imageRight)
            if let url: String = imageArray![0] {
                imageRight.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Picture))
            }
            
            //设置滚动视图大小
            scrollView.contentSize = CGSize(width: VIEW_WIDTH * CGFloat(count), height: VIEW_HEIGHT)
            //设置前后多滚动一张图片的宽度
            scrollView.contentInset = UIEdgeInsetsMake(0, VIEW_WIDTH, 0, VIEW_WIDTH)
        }
        
        //设置定时器
        if timer?.valid != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(8, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    //点击banner图片
    func clickBanner(gestureRecognizer: UIGestureRecognizer) {
        
        let view: UIImageView = gestureRecognizer.view as! UIImageView
        
        if delegate != nil {
            delegate.bannerView(self, didSelectedBannerAtIndex: view.tag)
        }
    }
    
    //自动滚动banner
    func autoScroll() {
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + VIEW_WIDTH, y: 0), animated: true)
    }
    
//  MARK: Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //获取当前滚动的偏移量
        let point: CGPoint = scrollView.contentOffset
        
        //设置当前分页
        pageControl.currentPage = Int(point.x / VIEW_WIDTH + 0.5)
        
        if point.x == -VIEW_WIDTH {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width - VIEW_WIDTH, y: 0), animated: false)
        }
        if point.x == scrollView.contentSize.width {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
    
}
