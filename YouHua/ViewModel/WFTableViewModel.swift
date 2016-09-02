//
//  WFTableViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/8/30.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias cellRenderBlock = (t: UITableView, i: NSIndexPath) -> UITableViewCell
typealias cellSelectBlock = (t: UITableView, i: NSIndexPath) -> Void

class WFTableViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var cellRender: cellRenderBlock!
    var cellSelect: cellSelectBlock?
    
    var cellHeight: CGFloat = 30
    var cellCount: Int = 0
    
    
//  MARK: - Delegate
    //cell个数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellCount
    }
    //cell行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return cellHeight
    }
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = cellRender(t: tableView, i: indexPath)
        return cell
    }
    //点击
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let selectBlock = cellSelect else {
            return
        }
        print("viewModel: \(indexPath.row)")
        selectBlock(t: tableView, i: indexPath)
    }
}
