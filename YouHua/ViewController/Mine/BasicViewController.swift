//
//  BasicViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias BasicProtocol = protocol<UITableViewDelegate, UITableViewDataSource>

class BasicViewController: UIViewController, BasicProtocol {
    
    let cellIdentifier = "cellid"
    var cellHeight: CGFloat = 0
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.backgroundColor = Color_White
        //temp.separatorStyle = .None
        temp.tableFooterView = UIView()
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
        
        self.view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "编辑个人资料"
        setNavigationItem(title: "ic_nav_second_back_normal_17x17_.png", selector: #selector(backViewAction), isRight: false)
        setNavigationItem(title: "保存", selector: #selector(saveAction), isRight: true)
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        //注册cell
        tableView.registerClass(BasicViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
    }
    
    func saveAction() {
        
        print("保存资料")
    }
    
//  MARK: - Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: BasicViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! BasicViewCell
        
        var body: String = ""
        
        if indexPath.row % 2 == 0 {
            
            body = "“有花”希望给所有喜欢植物和美学的人们, 带来的不单纯是花的美丽。更想通过花草与时间的叠加,营造一个你所期待的生活方式。"
        }else{
            body = "成都馨居尚装饰设计工程有限公司，是一家集家居装修、办公空间、公共空间、软装设计与施工的大型家装公司。公司总部位于成都市驷马桥羊子山路圣地亚家居A区4楼，占地面积8000余平米，是西南规模最大家居连锁情景展示卖场。"
        }
        
        self.cellHeight = cell.rowHeight(body)
        
        cell.txt.attributedText = body.stringWithParagraphlineSpeace(4, color: Color_Tags, font: UIFont(fontSize: 14))
        
        return cell
    }
    
    deinit {
        print("BasicViewController deinit")
    }
}
