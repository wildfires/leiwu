//
//  MallReusableView.swift
//  YouHua
//
//  Created by 高洋 on 16/9/16.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

enum MallReusableViewType: Int {
    case Header
    case Footer
}

class MallReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(viewType: MallReusableViewType) {
        
        switch viewType {
            case .Header:
                initHeaderView()
            case .Footer:
                initFooterView()
        }
    }
    
    func initHeaderView() {
        
    }
    
    func initFooterView() {
        
    }
}