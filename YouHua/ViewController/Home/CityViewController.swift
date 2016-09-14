//
//  CityViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/2.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias CityProtocol = protocol<UITableViewDelegate, UITableViewDataSource>

class CityViewController: UIViewController, CityProtocol {

    let citys = ["北京市", "上海市", "天津市", "重庆市", "合肥市", "毫州市", "芜湖市", "马鞍山市", "池州市", "黄山市", "滁州市", "安庆市", "淮南市", "淮北市", "蚌埠市", "巢湖市", "宿州市", "六安市", "阜阳市", "铜陵市", "明光市", "天长市", "宁国市", "界首市", "桐城市", "广州市", "韶关市", "深圳市", "珠海市", "汕头市", "佛山市", "江门市", "湛江市", "茂名市", "肇庆市", "惠州市", "梅州市", "汕尾市", "河源市", "阳江市", "清远市", "东莞市", "中山市", "潮州市", "揭阳市", "云浮市", "昆明市", "曲靖市", "玉溪市", "保山市", "昭通市", "丽江市", "思茅市", "临沧市", "楚雄彝族自治州", "红河哈尼族彝族自治州", "文山壮族苗族自治州", "西双版纳傣族自治州", "大理白族自治州", "德宏傣族景颇族自治州", "怒江傈僳族自治州", "迪庆藏族自治州"]
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
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
        
        navigationItem.title = "当前城市－成都"
        setNavigationItem(title: "X", selector: #selector(backViewAction), isRight: false)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

//  MARK: - Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citys.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    deinit {
        print("CityViewController deinit")
    }
}
