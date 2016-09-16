//
//  MallViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/8/30.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class MallViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let viewModel = MallViewModel()
    let cellIdentifier = "mallCell"
    
    
    lazy var collectionView: UICollectionView = {
        //对象大小
        let itemSize: CGFloat = (Screen_Width - 3 * Margin_Width) / 2
        //布局对象
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsetsMake(Margin_Width, Margin_Width, Margin_Width, Margin_Width)
        flowLayout.itemSize = CGSize(width: itemSize, height: itemSize + 90 + Margin_Width)
        flowLayout.minimumInteritemSpacing = Margin_Width //列间距
        flowLayout.minimumLineSpacing = Margin_Width //行间距
        
        let temp = UICollectionView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height), collectionViewLayout: flowLayout)
        temp.backgroundColor = Color_Background
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
        
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //注册cell
        collectionView.registerClass(MallViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        
        //注册header
        collectionView.registerClass(MallReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        //注册footer
        collectionView.registerClass(MallReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        viewModel.loadHomeNewData(collectionView) { (result) in
            
            self.viewModel.collectionArray = result
            self.collectionView.reloadData()
        }
        
        viewModel.loadHomeMoreData(collectionView) { (result) in
            
            self.viewModel.collectionArray += result
            self.collectionView.reloadData()
        }
    }
    
//  MARK: - Delegate
    
    //分组头部、尾部
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionElementKindSectionHeader:
                
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! MallReusableView
                headerView.initView(MallReusableViewType.Header)
                return headerView
            case UICollectionElementKindSectionFooter:
                
                let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath) as! MallReusableView
                footerView.initView(MallReusableViewType.Footer)
                return footerView
            default:
                return MallReusableView()
        }
    }
    
    //返回分组的头部视图的尺寸，在这里控制分组头部视图的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: Screen_Width, height: 180)
    }
    
    //返回分组脚部视图的尺寸，在这里控制分组脚部视图的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: Screen_Width, height: 50)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.cellNumberOfRows //photosArray.count == 0 ? 1 : photosArray.count + 1// photosArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: MallViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! MallViewCell
        
        let data = viewModel.collectionArray[indexPath.row]
        if let url: String = data.cover {
            cell.coverView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: Thumb_Avatar))
        }
        cell.titleLabel.text = "耒朴&手提象白壶"
        cell.priceLabel.text = "168元/个"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
}
