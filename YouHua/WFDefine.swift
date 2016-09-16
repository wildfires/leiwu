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

//屏幕尺寸
public let Screen_Width: CGFloat = UIScreen.mainScreen().bounds.size.width
public let Screen_Height: CGFloat = UIScreen.mainScreen().bounds.size.height

//间距
public let Margin_Width: CGFloat = 10
public let Margin_Height: CGFloat = 14

//状态码
public let Code_Success: Int = 200

//颜色定义
public func RGBA(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
}

public let Color_ButtonMore: UIColor = UIColor(r: 146, g: 115, b: 87)
public let Color_Button: UIColor = UIColor(r: 22, g: 163, b: 95) //#16a35f 小面积使用 用于重要文字、按钮、图标
public let Color_Title: UIColor = UIColor(r: 51, g: 51, b: 51) //#333333 用于强调或突出文字、内页标题
public let Color_Description: UIColor = UIColor(r: 102, g: 102, b: 102) //#666666 用于普通段落信息 引导词
public let Color_Tags: UIColor = UIColor(r: 153, g: 153, b: 153) //#999999 用于辅助、次要文字
public let Color_Line: UIColor = UIColor(r: 227, g: 228, b: 232) //#e3e4e8 用于分割线、标签描述
public let Color_Background: UIColor = UIColor(r: 244, g: 245, b: 249) //#f4f5f9 用于内容区底色
public let Color_White: UIColor = UIColor.whiteColor()
public let Color_Black: UIColor = UIColor.blackColor()
public let Color_Red: UIColor = UIColor.redColor()
public let Color_Gray: UIColor = UIColor.grayColor()

//字体
public let Font_Name: String = "Hiragino Sans GB"//"FZLanTingHeiS-EL-GB"

//默认图片
public let Thumb_Avatar: String = "avatar_00"
public let Thumb_Picture: String = "mine_normal"



