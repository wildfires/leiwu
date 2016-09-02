//
//  HomeViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import MJRefresh

typealias HomeProtocol = protocol<UITableViewDelegate, UITableViewDataSource, HomeCellBarViewDelegate, HomeCellViewDelegate, AvatarViewDelegate>

class HomeViewController: UIViewController, HomeProtocol {
    
    var viewModel = HomeViewModel()
    let cellIdentifier = "cellid"
    var rowHeight: CGFloat = 0
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        temp.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        temp.separatorStyle = .None
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        headerRefreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//  MARK: - Navigation
    func initView() {
        
        setNavigationItem(title: "城市", selector: #selector(city), isRight: false)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //注册Cell
        tableView.registerClass(HomeViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headerRefreshData))
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(footerRefreshData))
    }
    
    func headerRefreshData() {
        
        viewModel.currentPage = 1
        requestData()
        tableView.mj_header.endRefreshing()
    }
    
    func footerRefreshData() {
        
        requestData()
        tableView.mj_footer.endRefreshing()
    }
    
    func requestData() {
        
        viewModel.fetchHomeData() { (success) in
            
            guard success == true else {
                return
            }
            self.viewModel.currentPage += 1
            self.tableView.reloadData()
        }
    }
    
    func city() {
        print("city")
        
        let cityVC = TestViewController()
        cityVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(cityVC, animated: true)
    }
    
//  MARK: - Delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return rowHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.cellNumberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: HomeViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! HomeViewCell
        
        if let data: HomeModel = viewModel.tableArray[indexPath.row] {
            cell.configureCell(data, indexPath: indexPath)
            self.rowHeight = cell.rowHeight(data.content)
            cell.avatarView.delegate = self
            cell.homeCellView.delegate = self
            cell.homeCellView.barView.delegate = self
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let data = viewModel.tableArray[indexPath.row]
        
        let detailVC = DetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.detail_id = data.did
        //detailVC.toArray = viewModel.tableArray
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func homeCellView(cell: HomeCellView, didSelectedVideoAtIndex row: Int) {
        
        let data = viewModel.tableArray[row]
        
        let videoVC = VideoViewController()
        videoVC.hidesBottomBarWhenPushed = true
        videoVC.videoUrl = data.video
        presentViewController(videoVC, animated: true, completion: nil)
    }
    
    func avatarView(didSelectedAvatarAtIndex row: Int) {
        
        let data = viewModel.tableArray[row]
        
        let mineVC = MineViewController()
        mineVC.userid = data.did
        mineVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mineVC, animated: true)
    }
    
    func homeCellBarViewDidSelectedButton(didSelectedAtIndex row: Int, didSelectedAtTag tag: Int) {
        
        let data = viewModel.tableArray[row]
        
        switch tag {
            case (row + 1):
                
                print("\(data.did) \(row) \(1)")
            
            case (row + 2):
                
                print("\(data.did) \(row) \(2)")
            case (row + 3):
                
                
                let shareView: ShareView = ShareView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
                shareView.showInView()
            default:
                break
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //print(scrollView.contentOffset.y)
    }
    
    deinit {
        print("HomeViewController deinit")
    }
}