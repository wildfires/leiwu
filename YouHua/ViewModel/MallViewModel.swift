//
//  MallViewModel.swift
//  YouHua
//
//  Created by 高洋 on 16/9/16.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import MJRefresh

typealias MallViewModelFinished = (success: Bool) -> ()
typealias MallViewModelDataFinished = (result: [HomeModel]) -> ()

class MallViewModel: NSObject, WFProgress {

    var currentPage: Int = 0
    
    var collectionArray = [HomeModel]()
    
    var cellNumberOfRows: Int {
        
        return collectionArray.count
    }
    
    func loadHomeNewData(collectionView: UICollectionView, finished: MallViewModelDataFinished) {
        
        //weak var weakSelf: HomeViewModel? = self
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            
            let params: [String: AnyObject] = [
                "page": 0
            ]
            
            WFNetwork.shareNetwork.WFGET(home_url, parameters: params, finished: { (success, result, error) in
                
                collectionView.mj_header.endRefreshing()
                guard let result = result where success == true else {
                    return
                }
                
                guard let data = result.arrayObject else {
                    return
                }
                
                var tempData = [HomeModel]()
                for dict in data {
                    tempData.append(HomeModel(dict: dict as! [String : AnyObject]))
                }
                finished(result: tempData)
            })
        })
        //根据拖拽比例自动切换透明度
        collectionView.mj_header.automaticallyChangeAlpha = true
        collectionView.mj_header.beginRefreshing()
    }
    
    func loadHomeMoreData(collectionView: UICollectionView, finished: MallViewModelDataFinished) {
        
        weak var weakSelf: MallViewModel? = self
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            
            let params: [String: AnyObject] = [
                "page": weakSelf!.currentPage
            ]
            print("f:\(params)")
            WFNetwork.shareNetwork.WFGET(home_url, parameters: params, finished: { (success, result, error) in
                
                collectionView.mj_footer.endRefreshing()
                guard let result = result where success == true else {
                    return
                }
                
                guard let data = result.arrayObject else {
                    return
                }
                
                var tempData = [HomeModel]()
                for dict in data {
                    tempData.append(HomeModel(dict: dict as! [String : AnyObject]))
                }
                weakSelf!.currentPage += 1
                finished(result: tempData)
            })
        })
    }
}
