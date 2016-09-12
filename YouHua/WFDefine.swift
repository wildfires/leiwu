//
//  WFDefine.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
//import Foundation

public let API_RUL: String = "http://n.xinjushang.com" ///n
public let home_url: String = "/api/get_home/"
public let login_url: String = "/api/login/"
public let register_url: String = "/api/register/"

public let banner_url: String = "/json/api.php"
public let compose_url: String = "/json/upload.php"

//状态码
public let RETURN_CODE: Int = 200

public let SCREEN_WIDTH: CGFloat = UIScreen.mainScreen().bounds.size.width
public let SCREEN_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.size.height

func RGBA(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}

public let BtnColor: UIColor = UIColor(red: 22/255.0, green: 163/255.0, blue: 95/255.0, alpha: 1.0) //#16a35f 小面积使用 用于重要文字、按钮、图标
public let MainColor: UIColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0) //#333333 用于强调或突出文字、内页标题

public let SubColor: UIColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0) //#666666 用于普通段落信息 引导词
public let RGB9Color: UIColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0) //#999999 用于辅助、次要文字
public let RGB3Color: UIColor = UIColor(red: 227/255.0, green: 228/255.0, blue: 232/255.0, alpha: 1.0) //#e3e4e8 用于分割线、标签描述

public let RGB2Color: UIColor = UIColor(red: 244/255.0, green: 245/255.0, blue: 249/255.0, alpha: 1.0) //#f4f5f9 用于内容区底色
public let RGB1Color: UIColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0) //#f8f8f8 用于分割块底色

public let WHITE_COLOR: UIColor = UIColor.whiteColor()
public let BLACK_COLOR: UIColor = UIColor.blackColor()
public let RED_COLOR: UIColor = UIColor.redColor()



public let FONT_NAME: String = "Hiragino Sans GB"//"FZLanTingHeiS-EL-GB"

public let THUMB_IMG: String = "mine_normal"


