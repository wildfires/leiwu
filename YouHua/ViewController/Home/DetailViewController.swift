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

    var viewModel = DetailViewModel()
    
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
        temp.initView(AvatarSize.Large, boxSize: 36)
        temp.headView.layer.cornerRadius = 0
        temp.headView.layer.masksToBounds = false
        return temp
    }()
    
    lazy var followButton: UIButton = {
        let temp = UIButton(image: "follow_icon_retweet", title: "关注", font: UIFont(fontSize: 12), color: UIColor.whiteColor())
        temp.frame = CGRect(x: 0, y: 8, width: 70, height: 30)
        temp.backgroundColor = Color_White
        temp.setTitleColor(Color_Button, forState: .Normal)
        temp.layer.borderWidth = 1
        temp.layer.borderColor = Color_Button.CGColor
        temp.layer.cornerRadius = 3
        temp.layer.masksToBounds = true
        temp.addTarget(self, action: #selector(followAction(_:)), forControlEvents: .TouchUpInside)
        return temp
    }()
    
    lazy var detailBarView: DetailBarView = {
        let temp = DetailBarView()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: followButton)
        
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
        
        viewModel.loadContentData(detail_id) { (result) in
            
            weakSelf!.viewModel.contentArray = result
            weakSelf!.tableView.reloadData()
        }
        
        viewModel.loadCommentData(detail_id) { (result) in
            
            weakSelf!.viewModel.commentArray = result
            weakSelf!.tableView.reloadData()
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
                
                return viewModel.cellContentNumberOfRows
            case 1:
                
                return viewModel.cellCommentNumberOfRows
            default:
                
                return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            case 0:
                
                let cell: CommentTopCell = tableView.dequeueReusableCellWithIdentifier(contentCellIdentifier) as! CommentTopCell
                
                if let contentData: HomeModel = viewModel.contentArray[detail_id] {
                    cell.configureCell(contentData, indexPath: indexPath)
                    self.contentRowHeight = cell.rowHeight(contentData.content!)
                    
                    avatarView.delegate = self
                    avatarView.headView.tag = indexPath.row
                    avatarView.nickLabel.tag = indexPath.row
                    if let url: String = contentData.avatar {
                        avatarView.headView.sd_setImageWithURL(NSURL(string: url))
                    }
                    avatarView.nickLabel.text = contentData.nickname
                    avatarView.shortLabel.text = "耒物创始人"//String(condata.dateline)//.withDate
                }
                
                return cell
            case 1:
                
                let cell: CommentViewCell = tableView.dequeueReusableCellWithIdentifier(commentCellIdentifier) as! CommentViewCell
                
                //models.objectAtIndex(indexPath.row) as? WXStatusModel
                if let commentData: HomeModel = viewModel.commentArray[indexPath.row] {
                    cell.configureCell(commentData, indexPath: indexPath)
                    self.commentRowHeight = cell.rowHeight(commentData.content!)
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
                headerView.backgroundColor = Color_Background
                let titleLabel: WFLabel = WFLabel(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 39))
                titleLabel.backgroundColor = Color_White
                titleLabel.text = "评论列表 \(viewModel.cellCommentNumberOfRows)"
                titleLabel.font = UIFont(fontSize: 14)
                titleLabel.textInsets = UIEdgeInsets(top: 0, left: Margin_Width, bottom: 0, right: 0)
                headerView.addSubview(titleLabel)
                
                return headerView
            default:
                
                return UIView()
        }
    }
    
    func avatarView(didSelectedAvatarAtIndex row: Int) {
        
        let data = viewModel.commentArray[row]
        
        let mineVC = MineViewController()
        mineVC.userid = data.did!
        mineVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mineVC, animated: true)
    }
    
    func detailBarView(didSelectedAtIndex row: Int, didSelectedAtTag tag: Int) {
        
        
    }
    
    func followAction(button: UIButton) {
        
        print("关注")
    }
    
    deinit {
        print("DetailViewController deinit")
    }
}