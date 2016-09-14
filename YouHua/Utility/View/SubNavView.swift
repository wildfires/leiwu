//
//  SubNavView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/7.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

protocol SubNavViewDelegate: NSObjectProtocol {
    func subNavViewDidSelectedButton(didSelectedAtIndex index: Int)
}

class SubNavView: UIView {

    weak var delegate: SubNavViewDelegate!
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    var menuSize: CGSize = CGSize(width: 60, height: 70)
    
    //var menuRow: Int = 1 //行 一行时不设置
    var menuCol: Int = 5 //列
    var menuMargin: CGFloat = 0 //间距
    
    var menuCount: Int = 5
    
    var menuPicArr: NSArray = ["18001","18001","18001","18001","18001"]
    var menuTitArr: NSArray = ["百科","视频","问答","商城","达人"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
        
        menuMargin = (VIEW_WIDTH - menuSize.width * CGFloat(menuCount)) / CGFloat(menuCount)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {
        
        for index in 0..<menuCount {
            
            let currentCol: Int = index % menuCol //当前列
            //let currentRow: Int = index / menuRow //当前行
            let btnX: CGFloat = CGFloat(currentCol) * (menuSize.width + menuMargin)
            let btnY: CGFloat = 10 //CGFloat(currentRow) * (menuMargin + menuSize.height)
            
            let menuBotton: UIButton = UIButton(image: menuPicArr[index] as? String, title: menuTitArr[index] as? String, size: CGSize(width: menuSize.width + menuMargin, height: menuSize.height), font: UIFont(fontSize: 12), color: Color_Black)
            menuBotton.frame = CGRect(x: btnX, y: btnY, width: menuSize.width, height: menuSize.height)
            menuBotton.addTarget(self, action: #selector(clickMenuAction(_:)), forControlEvents: .TouchUpInside)
            menuBotton.tag = 200 + index
            self.addSubview(menuBotton)
        }
    }
    
    //点击菜单
    func clickMenuAction(button: UIButton) {
        
        if delegate != nil {
            delegate.subNavViewDidSelectedButton(didSelectedAtIndex: button.tag)
        }
    }
}