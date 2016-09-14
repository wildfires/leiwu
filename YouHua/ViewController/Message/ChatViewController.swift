//
//  ChatViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/29.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

typealias ChatProtocol = protocol<UITableViewDelegate, UITableViewDataSource>

class ChatViewController: UIViewController, ChatProtocol {
    
    var toolBarHeight: CGFloat = 50
    //底部工具栏下约束Constraint?
    var bottomConstraint: Constraint?
    
    let cellIdentifier = "cellid"
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.separatorStyle = .None
        return temp
    }()
    //工具栏
    lazy var toolBar: ChatBarView = {
        let temp = ChatBarView()
        //frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.toolBarHeight)
        return temp
    }()
    
    //var toolBar: ChatBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        //注册通知 键盘打开
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        self.title = "与大方聊天中"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(tableView)
        self.view.addSubview(toolBar)
        
        //从底部显示信息
        //let indexPath: NSIndexPath = NSIndexPath(forRow: 9, inSection: 0)
        //tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
        
        //注册cell
        tableView.registerClass(MineViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        weak var weakSelf: ChatViewController? = self
//        tableView.snp_makeConstraints { (make) -> Void in
//            make.top.left.right.equalTo(weakSelf!.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
//            make.bottom.equalTo(weakSelf!.toolBar.snp_top).offset(0)
//        }
        
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(weakSelf!.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(toolBarHeight)
            weakSelf!.bottomConstraint = make.bottom.equalTo(weakSelf!.view).constraint
        }
    }
    
//  MARK: - 键盘弹出监控方法
    func keyboardWillShow(note: NSNotification) {
        
        if let userInfo = note.userInfo,
            value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.CGRectValue()
            let intersection = CGRectIntersection(frame, self.view.frame)
            
            //self.view.setNeedsLayout()
            //改变下约束
            self.bottomConstraint?.updateOffset(-CGRectGetHeight(intersection))
            
            UIView.animateWithDuration(duration, delay: 0.0,
                                       options: UIViewAnimationOptions(rawValue: curve),
                                       animations: { _ in
                                        self.view.layoutIfNeeded()
                }, completion: nil)
        }
        
//        // 1.取得弹出后的键盘frame
//        let frame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        // 2.键盘弹出的耗时时间
//        let duration = (note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
//        // 3.键盘变化时，view的位移，包括了上移/恢复下移
//        let transformY = frame.origin.y - SCREEN_HEIGHT
//        
//        ////toolBarConstranit.constant = height
//        
//        weak var weakSelf: ChatViewController? = self
//        UIView.animateWithDuration(duration) { () -> Void in
//            weakSelf!.view.transform = CGAffineTransformMakeTranslation(0, transformY)
//            //self.view.layoutIfNeeded()
//        }
    }
    
//  MARK: - Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: HomeViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! HomeViewCell
        cell.textLabel?.text = "聊天记录\(indexPath.row)"
        cell.textLabel?.font = UIFont(fontSize: 12)
        return cell
    }
    
    //滚动
//    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        //[self.view endEditing:YES];
//        
//    }
    
    deinit {
        print("ChatViewController deinit")
    }
}
