//
//  MessageViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/29.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias MessageProtocol = protocol<UITableViewDelegate, UITableViewDataSource>

class MessageViewController: UIViewController, MessageProtocol {

    let cellIdentifier = "cellid"
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        temp.separatorColor = UIColor.grayColor()
        temp.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0)
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
        
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //注册cell
        tableView.registerClass(MessageViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

//  MARK: - Delegate
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if section == 0 {
//            return 3
//        }
        
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MessageViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MessageViewCell
        
        //if indexPath.section == 0 {
           // cell.accessoryType = .DisclosureIndicator
           // cell.avatarView.image = UIImage(named: "img_01")
        //} else {
        
            cell.avatarView.image = UIImage(named: "img_02")
            cell.nickNameLabel.text = "小羊罢课"
            cell.digestLabel.text = "等会找你有事情，记得等我哦！，然后我们去老地方喝茶。"
            cell.dateLabel.text = "11:20"
        //}
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let chatVC = ChatViewController()
        chatVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    //删除
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //删除数据源的对应数据
        //dataScoure.removeAtIndex(indexPath.row)
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //numbers.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        //删除对应的cell
        //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        //self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
        //数据源为空的时候管理按钮不能删除
//        if self.dataScoure.count == 0{
//            barButtonItem?.enabled = false;
//        }
    }
    
    //把delete 该成中文
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        return "删除"
    }
    
    deinit {
        print("MessageViewController deinit")
    }
}
