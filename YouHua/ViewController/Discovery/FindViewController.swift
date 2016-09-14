//
//  FindViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/24.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import MJRefresh

typealias FindProtocol = protocol<UITableViewDelegate, UITableViewDataSource, BannerViewDelegate, SubNavViewDelegate, WFRichText>

class FindViewController: UIViewController, FindProtocol {

    let cellIdentifier = "cellid"
    var cellHight: CGFloat = 0
    
    var viewModel = FindViewModel()
    lazy var bannerView: BannerView = {
        let temp = BannerView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 200))
        temp.backgroundColor = Color_White
        return temp
    }()
    lazy var menuView: SubNavView = {
        let temp = SubNavView(frame: CGRect(x: 0, y: 200, width: Screen_Width, height: 90))
        temp.backgroundColor = Color_White
        return temp
    }()
    lazy var headerView: UIView = {
        let temp = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 300))
        temp.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        return temp
    }()
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        temp.separatorStyle = .None
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        self.headerView.addSubview(bannerView)
        self.headerView.addSubview(menuView)
        
        tableView.tableHeaderView = headerView
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        bannerView.delegate = self
        menuView.delegate = self
        
        //注册cell
        tableView.registerClass(FindViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshData))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshData))
    }
    
    func requestData() {
//        viewModel.networkRequestData()
//        bannerView.imageArray = viewModel.bannerArray as? Array
//        tableView.reloadData()
//        
        viewModel.networkRequestData { (success) in
            
            self.bannerView.imageArray = self.viewModel.bannerArray as? Array
            self.tableView.reloadData()
        }
    }
    
    func headerRefreshData() {
        requestData()
        tableView.mj_header.endRefreshing()
    }
    
    func footerRefreshData() {
        requestData()
        tableView.mj_footer.endRefreshing()
    }
    
//  MARK: - Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: FindViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! FindViewCell
        
        cell.coverView.image = UIImage(named: "img_0\(indexPath.row + 1)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

    func bannerView(bannerView: BannerView, didSelectedBannerAtIndex index: Int) {
        
        let mineVC = MineViewController()
        mineVC.userid = 2
        mineVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mineVC, animated: true)
    }
    
    func subNavViewDidSelectedButton(didSelectedAtIndex index: Int) {
        
        switch index {
            case 200:
                let cateVC = CateViewController()
                cateVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(cateVC, animated: true)
            case 201:
                
                print(1)
            case 202:
                
                print(2)
            case 203:
                
                print(3)
            case 204:
                
                print(4)
            default:
                break
        }
    }
    
    deinit {
        print("FindViewController deinit")
    }
}
