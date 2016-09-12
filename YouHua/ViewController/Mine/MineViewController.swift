//
//  MineViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/29.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

typealias MineProtocol = protocol<UICollectionViewDelegate, UICollectionViewDataSource>

class MineViewController: UIViewController, MineProtocol {

    let cellIdentifier = "cellid"
    var userid: Int = 0
    let headHeight: CGFloat = 200
    
    var viewModel = MineViewModel()
    
    lazy var headView: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 260))
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        
        return temp
    }()
    
    lazy var collectionView: UICollectionView = {
        //布局cell
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 2) / 3, height: (SCREEN_WIDTH - 2) / 3)
        flowLayout.minimumInteritemSpacing = 1 //列间距
        flowLayout.minimumLineSpacing = 1 //行间距
        
        let temp = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: flowLayout)
        temp.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        return temp
    }()
    
    lazy var composeButton: UIButton = {
        let temp = UIButton(frame: CGRect(x: (SCREEN_WIDTH - 50) / 2, y: SCREEN_HEIGHT - 100, width: 50, height: 50))
        temp.backgroundColor = UIColor.greenColor()
        temp.layer.cornerRadius = 25
        temp.layer.masksToBounds = true
        temp.layer.borderColor = UIColor.whiteColor().CGColor
        temp.layer.borderWidth = 0.5
        temp.addTarget(self, action: #selector(composeAction), forControlEvents: .TouchUpInside)
        temp.hidden = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func isLogin() -> Bool {
        
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        //viewWillDisappear UIViewController对象的视图即将消失、被覆盖或是隐藏时调用
        //setNavigationBarWithAlpha(1)
        
    }
    
    func initView() {
        
        if userid > 1 {
            navigationItem.title = "大方同学"
            setNavigationItem(title: "ic_nav_second_back_normal_17x17_.png", selector: #selector(backViewAction), isRight: false)
            composeButton.hidden = true
        } else {
            navigationItem.title = "小羊罢课"
            setNavigationItem(title: "ic_me_item_setting_20x20_.png", selector: #selector(settingViewAction), isRight: true)
            composeButton.hidden = false
        }
        
        self.view.addSubview(collectionView)
        self.view.addSubview(composeButton)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //注册cell
        collectionView.registerClass(MineViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        //注册header
        collectionView.registerClass(MineReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshData))
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshData))
    }
    
    func headerRefreshData() {
        
        collectionView.mj_header.endRefreshing()
    }
    
    func footerRefreshData() {
        
        collectionView.mj_footer.endRefreshing()
    }
    
    func basicAction() {
        
        let basicVC = BasicViewController()
        basicVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(basicVC, animated: true)
    }
    
    func settingViewAction() {
        
//        print("退出登录")
//        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isLogin")
        viewModel.logout()
        
        // 弹出一个controller
        let loginVC = LoginAndRegController()
        loginVC.initView(LoginRegViewType.Login)
        //退出后 如果不登陆跳转到首页
        loginVC.isJumpHomeViewController = true
        
        //登陆后改变tabbar当前view
        loginVC.dismissLoginViewController = { [weak self] in
            self!.tabBarController?.selectedIndex = 0
        }
        
        presentViewController(loginVC, animated: true, completion: nil)
    }
    
    func composeAction() {
        
        let composeVC = ComposeViewController()
        let nav = UINavigationController(rootViewController: composeVC)
        presentViewController(nav, animated: true, completion: nil)
    }
    
//  MARK: - Delegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 90
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: SCREEN_WIDTH, height: 200)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionElementKindSectionHeader:
                
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! MineReusableView
                headerView.initHeaderView()
                
                if userid > 0 {
                    headerView.followAndEditButton.setTitle("+ 关注", forState: .Normal)
                    headerView.followAndEditButton.addTarget(self, action: #selector(basicAction), forControlEvents: .TouchUpInside)
                    
                    headerView.avatarView.image = UIImage(named: "logo")
                    headerView.sexView.image = UIImage(named: "sex2")
                    headerView.sexView.backgroundColor = RGBA(red: 226, green: 49, blue: 65, alpha: 1)
                    headerView.trendsView.numberLabel.text = "193.5k"
                    headerView.followsView.numberLabel.text = "18"
                    headerView.fansView.numberLabel.text = "1.0k"
                    headerView.addressButton.setTitle("武汉 黄石市", forState: .Normal)
                    headerView.signLabel.attributedText = "有花,就是我一直寻找的东西。".stringWithParagraphlineSpeace(6, color: UIColor.greenColor(), font: UIFont(name: FONT_NAME, size: 14)!)
                } else {
                    headerView.followAndEditButton.setTitle("编辑个人资料", forState: .Normal)
                    headerView.followAndEditButton.addTarget(self, action: #selector(basicAction), forControlEvents: .TouchUpInside)
                    
                    headerView.avatarView.image = UIImage(named: "img_09")
                    headerView.sexView.image = UIImage(named: "sex1")
                    headerView.sexView.backgroundColor = RGBA(red: 79, green: 148, blue: 291, alpha: 1)
                    headerView.trendsView.numberLabel.text = "93.7k"
                    headerView.followsView.numberLabel.text = "198"
                    headerView.fansView.numberLabel.text = "1.6k"
                    headerView.addressButton.setTitle("北京 朝阳区", forState: .Normal)
                    headerView.signLabel.attributedText = "精选,分享,讨论是我们的建站使命。在这里你可以最短的时间收集灵感,寻找有趣的东西。".stringWithParagraphlineSpeace(6, color: UIColor.greenColor(), font: UIFont(name: FONT_NAME, size: 14)!)
                }
                //传入不同数组给数据
                
                
                //headerView.backgroundColor = UIColor.grayColor()
                
                return headerView
            default:
                return MineReusableView()
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: MineViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! MineViewCell
        cell.coverView.image = UIImage(named: "img_0\(arc4random() % 10)")
        cell.backgroundColor = UIColor.grayColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        let loginVC = LoginAndRegController()
        loginVC.initView(LoginRegViewType.Login)
        presentViewController(loginVC, animated: true, completion: nil)
    }
    
    deinit {
        print("MineViewController deinit")
    }
}
