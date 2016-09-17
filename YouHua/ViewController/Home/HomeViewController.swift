//
//  HomeViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias HomeProtocol = protocol<UITableViewDelegate, UITableViewDataSource, HomeViewCellBarDelegate, HomeViewCellContentDelegate, HomeViewCellAvatarDelegate>

class HomeViewController: UIViewController, HomeProtocol {
    
    let cellIdentifier = "homeCellIdentifier"
    
    var viewModel = HomeViewModel()
    var rowHeight: CGFloat = 0
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        temp.separatorStyle = .None
        return temp
    }()
    
    lazy var composeButton: UIButton = {
        let temp = UIButton(frame: CGRect(x: (Screen_Width - 60), y: Screen_Height - 110, width: 46, height: 46))
        temp.backgroundColor = Color_Red
        temp.layer.cornerRadius = 25
        temp.layer.masksToBounds = true
        temp.layer.borderColor = Color_White.CGColor
        temp.layer.borderWidth = 0.5
        temp.addTarget(self, action: #selector(composeAction), forControlEvents: .TouchUpInside)
        temp.hidden = true
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
    

//  MARK: - Navigation
    func initView() {
        
        setNavigationItem(title: "icon_search.png", selector: #selector(city), isRight: false)
        self.view.addSubview(tableView)
        self.view.addSubview(composeButton)
        
        if MineViewModel.isLogin == true {
            composeButton.hidden = false
        } else {
            composeButton.hidden = true
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //注册Cell
        tableView.registerClass(HomeViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        
        //上拉和下拉加载数据
        viewModel.loadHomeNewData(tableView) { (result) in
            
            self.viewModel.tableArray = result
            self.tableView.reloadData()
        }
        
        viewModel.loadHomeMoreData(tableView) { (result) in
            
            self.viewModel.tableArray += result
            self.tableView.reloadData()
        }
    }
    
    func city() {
        print("city")
        
//        let cityVC = TestViewController()
//        cityVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(cityVC, animated: true)
    }
    
    func composeAction() {
        
        let composeVC = ComposeViewController()
        let nav = UINavigationController(rootViewController: composeVC)
        presentViewController(nav, animated: true, completion: nil)
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
            self.rowHeight = cell.rowHeight
            cell.homeViewCellAvatar.delegate = self
            cell.homeViewCellContent.delegate = self
            cell.homeViewCellBar.delegate = self
        }
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let detailVC = DetailViewController()
//        detailVC.hidesBottomBarWhenPushed = true
//        detailVC.detail_id = viewModel.tableArray[indexPath.row].did!
//        //detailVC.toArray = viewModel.tableArray
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
    
    func homeViewCellAvatar(didSelectedAvatarAtIndex row: Int) {
        
        let mineVC = MineViewController()
        mineVC.userid = viewModel.tableArray[row].did!
        mineVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mineVC, animated: true)
    }
    
    func homeViewCellContent(viewType: HomeViewCellContentType, didSelectedAtIndex row: Int) {
        
        //print("\(viewType) ... \(row)")
        let data = viewModel.tableArray[row]
        
        switch viewType {
            case .View:
                
                let detailVC = DetailViewController()
                detailVC.hidesBottomBarWhenPushed = true
                detailVC.detail_id = data.did!
                navigationController?.pushViewController(detailVC, animated: true)
            case .Cover:
                
                let coverVC = MineViewController()
                coverVC.hidesBottomBarWhenPushed = true
                coverVC.userid = data.did!
                navigationController?.pushViewController(coverVC, animated: true)
            case .Video:
                
                let videoVC = VideoViewController()
                videoVC.hidesBottomBarWhenPushed = true
                videoVC.videoUrl = data.video!
                presentViewController(videoVC, animated: true, completion: nil)
        }
    }
    
    func homeViewCellBar(didSelectedAtIndex row: Int, didSelectedAtTag tag: Int) {
        
        let data = viewModel.tableArray[row]
        
        switch tag {
            case (row + 1):
                
                print("\(data.did) \(row) \(1)")
            
            case (row + 2):
                
                print("\(data.did) \(row) \(2)")
            case (row + 3):
                
                let shareView: ShareView = ShareView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
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