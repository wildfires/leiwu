//
//  CateViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/6/28.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

typealias CateProtocol = protocol<UICollectionViewDelegate, UICollectionViewDataSource>

class CateViewController: UIViewController, CateProtocol {

    let cellIdentifier = "cellid"
    
    lazy var collectionView: UICollectionView = {
        
        //布局对象
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        flowLayout.itemSize = CGSize(width: (Screen_Width - 20) / 3, height: (Screen_Width - 20) / 3 + 30)
        flowLayout.minimumInteritemSpacing = 5 //列间距
        flowLayout.minimumLineSpacing = 5 //行间距
        
        let temp = UICollectionView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height), collectionViewLayout: flowLayout)
        temp.backgroundColor = Color_White
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
        
        //setNavigationItem(title: "<", selector: nil, isRight: false)
        self.title = "视频"
        
        self.view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //注册cell
        collectionView.registerClass(CateViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        //注册header
        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        //注册footer
        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
    }
    
//  MARK: - Delegate
    //section的个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 5
    }
    
    //Section中Item的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    //分组头部、尾部
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionElementKindSectionHeader:
            
            let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            header.backgroundColor = RGBA(red: 248, green: 248, blue: 248, alpha: 1)
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 30))
            titleLabel.text = " 植物种类"
            titleLabel.font = UIFont(fontSize: 14)
            header.addSubview(titleLabel)
            
            return header
        case UICollectionElementKindSectionFooter:
            
            let footer: UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
            footer.backgroundColor = RGBA(red: 225, green: 225, blue: 225, alpha: 1)
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 20))
            titleLabel.text = "更多"
            titleLabel.textAlignment = .Center
            titleLabel.font = UIFont(fontSize: 12)
            footer.addSubview(titleLabel)
            
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    //返回分组的头部视图的尺寸，在这里控制分组头部视图的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: Screen_Width, height: 30)
    }
    
    //返回分组脚部视图的尺寸，在这里控制分组脚部视图的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: Screen_Width, height: 20)
    }
    //item的大小
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cid", forIndexPath: indexPath)
        
        let cell: CateViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CateViewCell
        
        cell.coverView.image = UIImage(named: "img_0\(indexPath.row + 1)")
        cell.titleLabel.text = "多肉植物"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let listlVC = ListViewController()
        listlVC.hidesBottomBarWhenPushed = true
        listlVC.cate_id = indexPath.row as Int
        navigationController?.pushViewController(listlVC, animated: true)
    }
    
    deinit {
        print("CateViewController deinit")
    }
}
