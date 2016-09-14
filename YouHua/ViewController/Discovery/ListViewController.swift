//
//  ListViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/7.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias ListProtocol = protocol<UITableViewDelegate, UITableViewDataSource>

class ListViewController: UIViewController, ListProtocol {

    var cate_id: Int = 0
    let cellIdentifier = "cellid"
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.separatorStyle = .None
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
        
        navigationItem.title = "\(cate_id)"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(ListViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
    }
    
//  MARK: - Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ListViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! ListViewCell
        cell.coverView.image = UIImage(named: "img_01")
        cell.titleLabel.text = "无花果"
        cell.subTitleLabel.text = "文仙果、奶浆果、品仙果"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let showVC = ShowViewController()
        showVC.hidesBottomBarWhenPushed = true
        showVC.show_id = indexPath.row as Int
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    deinit {
        print("ListViewController deinit")
    }
}
