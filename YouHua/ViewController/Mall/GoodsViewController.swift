//
//  GoodsViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/9/17.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import MJRefresh

class GoodsViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {

    let cellIdentifier = "cellid"
    var cellHeight: CGFloat = 0
    
    lazy var scrollView: UIScrollView = {
        let temp = UIScrollView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.contentSize = CGSize(width: Screen_Width, height: 2 * Screen_Height)
        temp.backgroundColor = Color_Red
        //设置分页效果
        temp.pagingEnabled = true
        //禁用滚动
        temp.scrollEnabled = false
        return temp
    }()
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.tableFooterView = UIView()
        temp.showsVerticalScrollIndicator = false
        temp.backgroundColor = Color_Black
        return temp
    }()
    
    lazy var webView: UIWebView = {
        let temp = UIWebView(frame: CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: Screen_Height))
        temp.backgroundColor = Color_Button
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        self.view.backgroundColor = Color_White
        navigationItem.title = "好物详情"
        setNavigationItem(title: "ic_nav_second_back_normal_17x17_.png", selector: #selector(backViewAction), isRight: false)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(tableView)
        scrollView.addSubview(webView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.baidu.com")!))
        
        //注册cell
        tableView.registerClass(BasicViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        
        //商品信息
        //详情
        //好评
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            
            
            self.goDetailAnimation()
            self.tableView.mj_footer.endRefreshing()
        })
        
        webView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            
            self.goGoodsAnimation()
            self.webView.scrollView.mj_header.endRefreshing()
        })
    }
    
    
//  MARK: - Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: BasicViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! BasicViewCell
        
        let body: String = "“有花”希望给所有喜欢植物和美学的。"
        
        
        cell.txt.attributedText = body.stringWithParagraphlineSpeace(4, color: Color_Tags, font: UIFont(fontSize: 14))
        
        return cell
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        
        
//        CGFloat offsetY = scrollView.contentOffset.y;
//        
//        if([scrollView isKindOfClass:[UITableView class]]) // tableView界面上的滚动
//        {
//            // 能触发翻页的理想值:tableView整体的高度减去屏幕本省的高度
//            CGFloat valueNum = _tableView.contentSize.height -PDHeight_mainScreen;
//            if ((offsetY - valueNum) > _maxContentOffSet_Y)
//            {
//                [self goToDetailAnimation]; // 进入图文详情的动画
//            }
//        }
//            
//        else // webView页面上的滚动
//        {
//            NSLog(@"-----webView-------");
//            if(offsetY<0 && -offsetY>_maxContentOffSet_Y)
//            {
//                [self backToFirstPageAnimation]; // 返回基本详情界面的动画
//            }
//        }
        
//        let offsetY = scrollView.contentOffset.y
//        // tableView界面上的滚动
//        if scrollView.isKindOfClass(UITableView.classForCoder()) {
//            //能触发翻页的理想值:tableView整体的高度减去屏幕本省的高度
//            let valueNum: CGFloat = tableView.contentSize.height - Screen_Height
//            if offsetY - valueNum > 80 {
//                goDetailAnimation()
//            }
//        } else {
//            if offsetY < 0 && -offsetY > 80 {
//                goGoodsAnimation()
//            }
//        }
    }
    
    // 进入详情的动画
//    - (void)goToDetailAnimation
//    {
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//    _webView.frame = CGRectMake(0, 0, PDWidth_mainScreen, PDHeight_mainScreen);
//    _tableView.frame = CGRectMake(0, -self.contentView.bounds.size.height, PDWidth_mainScreen, self.contentView.bounds.size.height);
//    } completion:^(BOOL finished) {
//    
//    }];
//    }
//    
    func goDetailAnimation() {
        
        UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.LayoutSubviews, animations: { 
            
            self.webView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height)
            self.tableView.frame = CGRect(x: 0, y: -Screen_Height, width: Screen_Width, height: Screen_Height)
            }, completion: nil)
    }
//    
//    // 返回第一个界面的动画
//    - (void)backToFirstPageAnimation
//    {
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//    _tableView.frame = CGRectMake(0, 0, PDWidth_mainScreen, self.contentView.bounds.size.height);
//    _webView.frame = CGRectMake(0, _tableView.contentSize.height, PDWidth_mainScreen, PDHeight_mainScreen);
//    
//    } completion:^(BOOL finished) {
//    
//    }];
//    }
    func goGoodsAnimation() {
        
        UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.LayoutSubviews, animations: {
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height)
            self.webView.frame = CGRect(x: 0, y: Screen_Height, width: Screen_Width, height: Screen_Height)
            }, completion: nil)
    }
    
    deinit {
        print("GoodsViewController deinit")
    }
}