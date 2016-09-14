//
//  MallViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/8/30.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class MallViewController: UIViewController {

    let viewModel = WFTableViewModel()
    let cellIdentifier = "mallCell"
    
    
    lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        temp.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 1)
        //temp.separatorStyle = .None
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
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.registerClass(BasicViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        
        weak var weakSelf: MallViewController? = self
        viewModel.cellRender = { t, i in
            
            let cell: BasicViewCell = t.dequeueReusableCellWithIdentifier(weakSelf!.cellIdentifier) as! BasicViewCell
            cell.txt.text = "第\(i.row)个"
            return cell
        }
        
        viewModel.cellSelect = { t, i in
            
            print("view: \(i.row)")
        }
        
        viewModel.cellCount = 9
        viewModel.cellHeight = 100
    }
    
    
}
