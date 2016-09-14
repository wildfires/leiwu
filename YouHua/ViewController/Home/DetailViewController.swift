//
//  DetailViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/7.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

typealias DetailProtocol = protocol<UITableViewDelegate, UITableViewDataSource, AvatarViewDelegate, DetailBarViewDelegate, WFProgress>

class DetailViewController: UIViewController, DetailProtocol {

    var viewModel = HomeViewModel()
    //var toArray: Array<HomeModel> = []
    
    let contentCellIdentifier = "contentcellid"
    let commentCellIdentifier = "commentcellid"
    var detail_id: Int = 0
    var contentRowHeight: CGFloat = 0
    var commentRowHeight: CGFloat = 0
    
    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        temp.separatorStyle = .None
        return temp
    }()
    
    lazy var avatarView: AvatarView = {
        let temp = AvatarView(frame: CGRect(x: 0, y: 4, width: 160, height: 36))
        temp.headView.layer.cornerRadius = 0
        temp.headView.layer.masksToBounds = false
        return temp
    }()
    
    lazy var followButton: UIButton = {
        let temp = UIButton(image: "timeline_icon_retweet", title: "关注", font: UIFont(fontSize: 12), color: UIColor.whiteColor())
        temp.frame = CGRect(x: 0, y: 7, width: 70, height: 30)
        temp.backgroundColor = RGBA(red: 22, green: 164, blue: 174, alpha: 1)
        temp.layer.cornerRadius = 2
        temp.layer.masksToBounds = true
        
        return temp
    }()
    
    lazy var detailBarView: DetailBarView = {
        let temp = DetailBarView()
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        viewModel.fetchOneData(Int(detail_id)) { (success) in
            
            guard success == true else {
                return
            }
            self.tableView.reloadData()
        }
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: followButton)
        
        avatarView.initView(AvatarSize.Large, boxSize: 36)
        avatarView.headView.layer.cornerRadius = 0
        avatarView.headView.layer.masksToBounds = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tableView)
        self.view.addSubview(detailBarView)
        
        tableView.delegate = self
        tableView.dataSource = self
        detailBarView.delegate = self
        
        tableView.registerClass(CommentTopCell.classForCoder(), forCellReuseIdentifier: contentCellIdentifier)
        tableView.registerClass(CommentViewCell.classForCoder(), forCellReuseIdentifier: commentCellIdentifier)
        
        
        weak var weakSelf: DetailViewController? = self
        tableView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(weakSelf!.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.bottom.equalTo(detailBarView.snp_top).offset(0)
        }
        
        detailBarView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(weakSelf!.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(44)
        }
        
        followButton.addTarget(self, action: #selector(followAction(_:)), forControlEvents: .TouchUpInside)
    }
    
    func requestData() {
        
        viewModel.fetchHomeData() { (success) in
            
//            guard success == true else {
//                return
//            }
            self.tableView.reloadData()
        }
    }
    
//  MARK: - Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            
            return contentRowHeight
        case 1:
            
            return commentRowHeight
        default:
            
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case 0:
                
                return viewModel.cellTopNumberOfRows
            case 1:
                
                return viewModel.cellNumberOfRows
            default:
                
                return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            case 0:
                
                let cell: CommentTopCell = tableView.dequeueReusableCellWithIdentifier(contentCellIdentifier) as! CommentTopCell
                
                if let condata: HomeModel = viewModel.topArray[0] {
                    cell.configureCell(condata, indexPath: indexPath)
                    self.contentRowHeight = cell.rowHeight(condata.content!)
                    
                    avatarView.delegate = self
                    avatarView.headView.tag = indexPath.row
                    avatarView.nickLabel.tag = indexPath.row
                    if let url: String = condata.avatar {
                        avatarView.headView.sd_setImageWithURL(NSURL(string: url))
                    }
                    avatarView.nickLabel.text = condata.nickname
                    avatarView.shortLabel.text = String(condata.dateline)//.withDate
                }
                
                return cell
            case 1:
                
                let cell: CommentViewCell = tableView.dequeueReusableCellWithIdentifier(commentCellIdentifier) as! CommentViewCell
                
                //models.objectAtIndex(indexPath.row) as? WXStatusModel
                if let comdata: HomeModel = viewModel.tableArray[indexPath.row] {
                    cell.configureCell(comdata, indexPath: indexPath)
                    self.commentRowHeight = cell.rowHeight(comdata.content!)
                    cell.avatarView.delegate = self
                }
                return cell
            default:
                
                return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 1:
            return 40
        default:
            
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
            case 1:
                
                let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 40))
                headerView.backgroundColor = Color_Gray
                let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 39.5))
                titleLabel.backgroundColor = Color_White
                titleLabel.text = "  评论列表 \(viewModel.cellNumberOfRows)"
                titleLabel.font = UIFont(fontSize: 14)
                headerView.addSubview(titleLabel)
                
                return headerView
            default:
                
                return UIView()
        }
    }
    
    func avatarView(didSelectedAvatarAtIndex row: Int) {
        
        let data = viewModel.tableArray[row]
        
        let mineVC = MineViewController()
        mineVC.userid = data.did!
        mineVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mineVC, animated: true)
    }
    
    func followAction(button: UIButton) {
        
        print("关注")
    }
    
    deinit {
        print("DetailViewController deinit")
    }
}