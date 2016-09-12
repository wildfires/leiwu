//
//  StringExtension.swift
//  YouHua
//
//  Created by 高洋 on 16/6/26.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

extension Int {
    
    var withCount: String {
        
        if self >= 1000 {
            return String(self / 1000) + "k"
        }
        
        return String(self)
    }
    
    var withDate: String {
        
        let publishTime = NSDate(timeIntervalSince1970: NSTimeInterval(self))
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let delta = NSDate().timeIntervalSinceDate(publishTime)
        
        if (delta <= 0) {
            return "刚刚"
        }
        else if (delta < 60) {
            return "\(Int(delta))秒前"
        }
        else if (delta < 3600) {
            return "\(Int(delta / 60))分钟前"
        }
        else {
            let calendar = NSCalendar.currentCalendar()
            // 现在
            let comp = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: NSDate())
            // 发布时间
            let comp2 = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: publishTime)
            
            if comp.year == comp2.year {
                if comp.day == comp2.day {
                    return "\(comp.hour - comp2.hour)小时前"
                } else {
                    return "\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
                }
            } else {
                return "\(comp2.year)-\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
            }
        }
        
//        let formatter = NSDateFormatter()
//        var formatterStr: String?
//        let calendar = NSCalendar.currentCalendar()
//        if calendar.isDateInToday(self){
//            let seconds = (Int)(NSDate().timeIntervalSinceDate(self))
//            if seconds < 60{
//                return "刚刚"
//            }else if seconds < 60 * 60{
//                return "\(seconds/60)分钟前"
//            }else{
//                return "\(seconds/60/60)小时前"
//            }
//        }else if calendar.isDateInYesterday(self){
//            // 昨天: 昨天 17:xx
//            formatterStr = "昨天 HH:mm"
//        }else{
//            
//            // 很多年前: 2014-12-14 17:xx
//            // 如果枚举可以选择多个, 就用数组[]包起来, 如果为空, 就直接一个空数组
//            let components = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: [])
//            // 今年: 03-15 17:xx
//            if components.year < 1
//            {
//                formatterStr = "MM-dd HH:mm"
//            }else{
//                formatterStr = "yyyy-MM-dd HH:mm"
//            }
//        }
//        formatter.dateFormat = formatterStr
//        
//        return formatter.stringFromDate(self)
    }
}
extension String {
    
    /// 判断是否是手机号
    func isPhoneNumber() -> Bool {
        let pattern = "^1[345789]\\d{9}$"
        return NSPredicate.init(format: "SELF MATCHES %@", pattern).evaluateWithObject(self)
    }
    
    // int
    
    func makeTextWithCount() -> String {
        
        let conut: Int = Int(self)!
        
        if conut >= 1000 {
            return String(format: "%.1fk", conut / 1000)
        }
        
        return String(format: "%d", conut)
    }
    
    /// 判断是否是邮政编码
    func isPostCode() -> Bool {
        let pattern = "^\\d{6}$"
        return NSPredicate.init(format: "SELF MATCHES %@", pattern).evaluateWithObject(self)
    }
    
    // 处理日期的格式
    func changeDateTime(publish_time: Int) -> String {
        // 把秒转化成时间
        let publishTime = NSDate(timeIntervalSince1970: NSTimeInterval(publish_time))
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let delta = NSDate().timeIntervalSinceDate(publishTime)
        
        if (delta <= 0) {
            return "刚刚"
        }
        else if (delta < 60) {
            return "\(Int(delta))秒前"
        }
        else if (delta < 3600) {
            return "\(Int(delta / 60))分钟前"
        }
        else {
            let calendar = NSCalendar.currentCalendar()
            // 现在
            let comp = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: NSDate())
            // 发布时间
            let comp2 = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: publishTime)
            
            if comp.year == comp2.year {
                if comp.day == comp2.day {
                    return "\(comp.hour - comp2.hour)小时前"
                } else {
                    return "\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
                }
            } else {
                return "\(comp2.year)-\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
            }
        }
    }
    
    /**
     *  设置段落样式
     *
     *  @param lineSpacing 行高
     *  @param color   字体颜色
     *  @param font        字体
     *
     *  @return 富文本
     */
    func stringWithParagraphlineSpeace(lineSpacing: CGFloat, color: UIColor, font: UIFont) -> NSAttributedString {
        
        //设置段落
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        // 创建文字属性 //NSKernAttributeName字体间距, NSKernAttributeName: 0.4
        let attributes: NSDictionary = [NSParagraphStyleAttributeName: paragraphStyle, NSKernAttributeName: 0.6, NSForegroundColorAttributeName: color, NSFontAttributeName: font]
        
        let attriString: NSMutableAttributedString = NSMutableAttributedString(string: self, attributes: attributes as? [String : AnyObject])
        
        return attriString
    }
    
    /**
     *  计算富文本字体高度
     *
     *  @param lineSpeace 行高
     *  @param font       字体
     *  @param width      字体所占宽度
     *
     *  @return 富文本高度
     */
    func getSpaceLabelHeightWithSpeace(lineSpeace: CGFloat, font: UIFont, width: CGFloat) -> CGFloat {
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpeace
        
        //字体间距, NSKernAttributeName: 0.4
        let attributes: NSDictionary = [NSParagraphStyleAttributeName: paragraphStyle, NSKernAttributeName: 0.6, NSFontAttributeName: font]
        let text: NSString = self as NSString
        
        let size: CGSize = text.boundingRectWithSize(CGSize.init(width: width, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attributes as? [String : AnyObject], context: nil).size
        
        return size.height
    }
    
    //md5 32位 加密 （小写）
//    - (NSString *)md5_32 {
//    
//    
//    
//    const char *cStr = [self UTF8String];
//    
//    
//    
//    unsigned char result[32];
//    
//    
//    CC_LONG lentgh = (CC_LONG)strlen(cStr);
//    
//    CC_MD5( cStr,lentgh, result );
//    
//    return [NSString stringWithFormat:
//    
//    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//    
//    result[0],result[1],result[2],result[3],
//    
//    result[4],result[5],result[6],result[7],
//    
//    result[8],result[9],result[10],result[11],
//    
//    result[12],result[13],result[14],result[15],
//    
//    result[16], result[17],result[18], result[19],
//    
//    result[20], result[21],result[22], result[23],
//    
//    result[24], result[25],result[26], result[27],
//    
//    result[28], result[29],result[30], result[31]];
//    
//    }
//    
//    
//    
//    //md5 16位加密 （大写）
//    
//    -(NSString *)md5_16 {
//    
//    const char *cStr = [self UTF8String];
//    
//    unsigned char result[16];
//    
//    CC_LONG lentgh = (CC_LONG)strlen(cStr);
//    
//    CC_MD5(cStr,lentgh, result );
//    
//    return [NSString stringWithFormat:
//    
//    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//    
//    result[0], result[1], result[2], result[3],
//    
//    result[4], result[5], result[6], result[7],
//    
//    result[8], result[9], result[10], result[11],
//    
//    result[12], result[13], result[14], result[15]
//    
//    ];
//    }
}
